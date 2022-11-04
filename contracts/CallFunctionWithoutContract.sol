// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CallFunctionWithoutContract {
    address public s_selectorsAndSignaturesAddress;

    constructor(address selectorsAndSignaturesAddress) {
        s_selectorsAndSignaturesAddress = selectorsAndSignaturesAddress;
    }

    // pass in 0xa9059cbb000000000000000000000000d7acd2a9fd159e69bb102a1ca21c9a3e3a5f771b000000000000000000000000000000000000000000000000000000000000007b
    // you could use this to change state
    function callFunctionDirectly(bytes calldata callData) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = s_selectorsAndSignaturesAddress.call(
            abi.encodeWithSignature("getSelectorThree(bytes)", callData)
        );
        return (bytes4(returnData), success);
    }

    // with a staticcall, we can have this be a view function!
    function staticCallFunctionDirectly() public view returns (bytes4, bool) {
        (bool success, bytes memory returnData) = s_selectorsAndSignaturesAddress.staticcall(
            abi.encodeWithSignature("getSelectorOne()")
        );
        return (bytes4(returnData), success);
    }

    function callTransferFunctionDirectlyThree(address someAddress, uint256 amount)
        public
        returns (bytes4, bool)
    {
        (bool success, bytes memory returnData) = s_selectorsAndSignaturesAddress.call(
            abi.encodeWithSignature("transfer(address,uint256)", someAddress, amount)
        );
        return (bytes4(returnData), success);
    }
}