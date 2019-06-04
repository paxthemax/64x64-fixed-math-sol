pragma solidity ^0.5.7;

import "../lib/Q64x64FixedMath.sol";

contract Q64x64FixedMathMock {
    using Q64x64FixedMath for int256;
    using Q64x64FixedMath for int128;

    event LogInt256(int256 val, string msg);
    event LogInt128(int128 val, string msg);

    /**
        Equal to lowest possible (negative) signed 64b integer.
     */
    int64 private constant MIN_64 = -0x8000000000000000;

    /**
        Equal to highest possible signed 64b integer.
     */
    int64 private constant MAX_64 = 0x7FFFFFFFFFFFFFFF;

    function itoq(int256 val) public pure returns (int128) {
        // return Q64x64FixedMathMock.itoq(val);
        return val.itoq();
    }

    function qtoi(int128 val) public pure returns (int256) {
        // return Q64x64FixedMathMock.qtoi(val);
        return val.qtoi();
    }

    function add(int128 a, int128 b) public pure returns (int128) {
        // return Q64x64FixedMathMock.add(a, b);
        return a.add(b);
    }
}