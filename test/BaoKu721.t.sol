// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BaoKu721.sol";

contract BaoKuNFTTest is Test {
    BaokuNFT public baoku;

    function setUp() public {
        string memory name = "baoku";
        string memory short = "BK";
        baoku = new BaokuNFT(name, short);
        baoku.name();
    }

    function testName() public {
        assertEq(baoku.name(), "baoku");
    }

    // normal procedures
    // 1. issue product
    // 2. issue follow on product
    // 3. claim single
    // 4. claim batch
    // 5. transfer edition
    // 6. check owner
    function testIssueProduct() public{
        // test issue products

        BaokuNFT.digitalizedProductsMeta memory _dpm;
        _dpm.name = "name";
        _dpm.authors = "author";
        _dpm.productType = "product type";
        _dpm.productId = "product ID";
        baoku.issueProducts(1, 10, address(111), _dpm, "https://test.url");
        baoku.issueFollowOnProducts(1, 20);
        assertEq(baoku.editionTotalSupply(1), 30);


        // test claim edition to accounts
        vm.startPrank(address(111));
        baoku.claimSingleEdition(1, address(222));
        address[] memory accounts = new address[](3) ;
        // [address(333), address(333), address(222)]
        accounts[0] = address(333);
        accounts[1] = address(333);
        accounts[2] = address(222);
        baoku.claimBatchEdition(1, accounts);
        assertEq(baoku.current(1),4);
        assertEq(baoku.editionOwner(1, 1), address(222));
        assertEq(baoku.editionOwner(1, 2), address(333));
        assertEq(baoku.editionBalance(address(222), 1), 2);
        assertEq(baoku.editionBalance(address(222), 1), 2);
        assertEq(baoku.editionTotalSupply(1), 30);
        vm.stopPrank();


        vm.startPrank(address(222));
        baoku.transferEdition(1, 1, address (333));
        assertEq(baoku.editionOwner(1, 1), address(333));
        assertEq(baoku.editionBalance(address(222), 1), 1);
        assertEq(baoku.editionBalance(address(333), 1), 3);
        vm.stopPrank();

    }

}
