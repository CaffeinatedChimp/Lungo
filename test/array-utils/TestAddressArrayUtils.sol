pragma solidity 0.4.24;


import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

import "../../contracts/array-utils/AddressArrayUtils.sol";


contract TestAddressArrayUtils {
  using AddressArrayUtils for address[];

  address[] addressesA;
  address[] addressesB;
  address[] addressesC;

  function beforeEach() public {
    addressesA.length = 0;
    addressesB.length = 0;
    addressesC.length = 0;

    addressesA.push(address(0x1));
    addressesA.push(address(0x2));
    addressesA.push(address(0x3));
    addressesA.push(address(0x4));

    addressesB.push(address(0x8));
    addressesB.push(address(0x9));
    addressesB.push(address(0x10));
  }

  function testIsEqualTrue() public {
    addressesC.push(address(0x1));
    addressesC.push(address(0x2));
    addressesC.push(address(0x3));
    addressesC.push(address(0x4));
    bool equal = addressesA.isEqual(addressesC);
    Assert.equal(equal, true, "should return equal");
  }

  function testIsEqualFalse() public {
    bool equal = addressesA.isEqual(addressesB);
    Assert.equal(equal, false, "should not return not equal");
  }

  function testIndexFindsItem() public {
    (uint256 index, bool isIn) = addressesA.indexOf(address(0x2));
    Assert.isTrue(isIn, "should be ok");
    Assert.equal(index, 1, "should return index 1");
  }

  function testIndexDoesNotFindItem() public {
    (uint256 index, bool isIn) = addressesA.indexOf(address(0x0));
    Assert.isFalse(isIn, "should not be ok");
    Assert.equal(index, 0, "should return index 0");
  }

  function testContainsFindsItem() public {
    bool isIn = addressesA.contains(0x3);
    Assert.isTrue(isIn, "should be true");
  }

  function testContainsDoesNotFindItem() public {
    bool isIn = addressesA.contains(0x12);
    Assert.isFalse(isIn, "should be false");
  }

  function testExtendExtends() public {
    addressesA.extend(addressesB);
    Assert.equal(addressesA.length, 7, "extended length should be 7");
  }

  function testExtendExtendsEmpty() public {
    addressesA.extend(addressesC);
    Assert.equal(addressesA.length, 4, "extended length should be 4");
  }

  function testReverseEven() public {
    addressesA.reverse();
    Assert.equal(addressesA.length, 4, "reversed length should be 4");
    Assert.equal(addressesA[0], address(0x4), "element 0 should match");
    Assert.equal(addressesA[1], address(0x3), "element 1 should match");
    Assert.equal(addressesA[2], address(0x2), "element 2 should match");
    Assert.equal(addressesA[3], address(0x1), "element 3 should match");
  }

  function testReverseOdd() public {
    addressesB.reverse();
    Assert.equal(addressesB.length, 3, "reversed length should be 3");
    Assert.equal(addressesB[0], address(0x10), "element 0 should match");
    Assert.equal(addressesB[1], address(0x9), "element 1 should match");
    Assert.equal(addressesB[2], address(0x8), "element 2 should match");
  }

  function testRemoveIndex() public {
    uint256 length = addressesA.removeIndex(2);
    Assert.equal(length, 3, "returned length should be 3");
    Assert.equal(addressesA.length, 3, "removed length should be 3");
    Assert.equal(addressesA[0], address(0x1), "element 0 should match");
    Assert.equal(addressesA[1], address(0x2), "element 1 should match");
    Assert.equal(addressesA[2], address(0x4), "element 2 should match");
  }

  function testRemoveIndexOutOfBounds() public {
    uint256 length = addressesA.removeIndex(7);
    Assert.equal(length, 4, "returned length should be 4");
    Assert.equal(addressesA.length, 4, "length should be 4");
    Assert.equal(addressesA[0], address(0x1), "element 0 should match");
    Assert.equal(addressesA[1], address(0x2), "element 1 should match");
    Assert.equal(addressesA[2], address(0x3), "element 2 should match");
    Assert.equal(addressesA[3], address(0x4), "element 3 should match");
  }

  function testRemoveIndexLength0() public {
    uint256 length = addressesC.removeIndex(0);
    Assert.equal(length, 0, "returned length should be 0");
    Assert.equal(addressesC.length, 0, "length should be 3");
  }

  function testRemove() public {
    uint256 length = addressesA.remove(0x1);
    Assert.equal(length, 3, "returned length should be 3");
    Assert.equal(addressesA.length, 3, "removed length should be 3");
    Assert.equal(addressesA[0], address(0x4), "element 0 should match");
    Assert.equal(addressesA[1], address(0x2), "element 1 should match");
    Assert.equal(addressesA[2], address(0x3), "element 2 should match");
  }

  function testRemoveDoesNotExist() public {
    uint256 length = addressesA.remove(0x111);
    Assert.equal(length, 4, "returned length should be 4");
    Assert.equal(addressesA.length, 4, "length should be 4");
    Assert.equal(addressesA[0], address(0x1), "element 0 should match");
    Assert.equal(addressesA[1], address(0x2), "element 1 should match");
    Assert.equal(addressesA[2], address(0x3), "element 2 should match");
    Assert.equal(addressesA[3], address(0x4), "element 3 should match");
  }

}
