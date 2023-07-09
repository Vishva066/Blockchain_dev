//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MultiSigWallet {
    address[] public owners;          // List of wallet owners
    uint256 public requiredApprovals; // Number of required approvals
    mapping(address => bool) public isOwner;

    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool executed;
    }

    Transaction[] public transactions;

    event OwnerAdded(address newOwner);
    event OwnerRemoved(address removedOwner);
    event TransactionCreated(uint256 indexed txIndex, address indexed to, uint256 value, bytes data);
    event TransactionApproved(uint256 indexed txIndex);
    event TransactionExecuted(uint256 indexed txIndex);

    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not an owner");
        _;
    }

    modifier transactionExists(uint256 _txIndex) {
        require(_txIndex < transactions.length, "Transaction does not exist");
        _;
    }

    modifier notExecuted(uint256 _txIndex) {
        require(!transactions[_txIndex].executed, "Transaction already executed");
        _;
    }

    constructor(address[] memory _owners, uint256 _requiredApprovals) {
        require(_owners.length > 0 && _requiredApprovals > 0 && _requiredApprovals <= _owners.length, "Invalid parameters");
        for (uint256 i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0) && !isOwner[owner], "Invalid owner");
            isOwner[owner] = true;
            owners.push(owner);
        }
        requiredApprovals = _requiredApprovals;
    }

    function addOwner(address newOwner) public onlyOwner {
        require(newOwner != address(0) && !isOwner[newOwner], "Invalid new owner");
        isOwner[newOwner] = true;
        owners.push(newOwner);
        emit OwnerAdded(newOwner);
    }

    function removeOwner(address removedOwner) public onlyOwner {
        require(isOwner[removedOwner], "Invalid owner to remove");
        require(owners.length - 1 >= requiredApprovals, "Can't remove owner, not enough owners left");
        isOwner[removedOwner] = false;
        for (uint256 i = 0; i < owners.length; i++) {
            if (owners[i] == removedOwner) {
                owners[i] = owners[owners.length - 1];
                break;
            }
        }
        owners.pop();
        emit OwnerRemoved(removedOwner);
    }

    function createTransaction(address _to, uint256 _value, bytes memory _data) public onlyOwner {
        uint256 txIndex = transactions.length;
        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false
        }));
        emit TransactionCreated(txIndex, _to, _value, _data);
    }

    function approveTransaction(uint256 _txIndex) public onlyOwner transactionExists(_txIndex) notExecuted(_txIndex) {
        require(!transactions[_txIndex].executed, "Transaction already executed");
        transactions[_txIndex].executed = true;
        emit TransactionApproved(_txIndex);
    }

    function executeTransaction(uint256 _txIndex) public onlyOwner transactionExists(_txIndex) notExecuted(_txIndex) {
        require(approvalsCount(_txIndex) >= requiredApprovals, "Not enough approvals");
        Transaction storage transaction = transactions[_txIndex];
        (bool success, ) = transaction.to.call{value: transaction.value}(transaction.data);
        require(success, "Transaction execution failed");
        transaction.executed = true;
        emit TransactionExecuted(_txIndex);
    }

    function approvalsCount(uint256 _txIndex) public view returns (uint256) {
        uint256 count = 0;
        for (uint256 i = 0; i < owners.length; i++) {
            if (transactions[_txIndex].executed) {
                count++;
            }
        }
        return count;
    }
}

