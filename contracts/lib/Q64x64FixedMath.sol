
/*
 * Math 64.64 Smart Contract Library.
 * Author: Pavle Batuta <pavle.batuta@protonmail.com>
 *
 * Original implementation:
 * ABDK Math 64.64 Smart Contract Library.  Copyright © 2019 by ABDK Consulting.
 * Author: Mikhail Vladimirov <mikhail.vladimirov@gmail.com>
 */
pragma solidity ^0.5.7;

library Q64x64FixedMath {

    /**
        Minimum negative value a Q64.64 fixed point int may have, without underflowing.
        Equal to lowest possible (negative) signed 128b integer.
     */
    int128 private constant MIN_128 = -0x80000000000000000000000000000000;

    /**
        Maximum positive value a Q64.64 fixed point int may have without overflowing.
        Equal to highest possible signed 128b integer.
     */
    int128 private constant MAX_128 = 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;


    /**
        Equal to lowest possible (negative) signed 64b integer.
     */
    int64 private constant MIN_64 = -0x8000000000000000;

    /**
        Equal to highest possible signed 64b integer.
     */
    int64 private constant MAX_64 = 0x7FFFFFFFFFFFFFFF;

    /**
        Convert signed int to Q64.64 fixed format.
        Reverts if signed int would overflow 64b.
     */
    function itoq(int256 val)
        internal
        pure
        returns (int128)
    {
        require(
            val >= MIN_64 && val <= MAX_64,
            "Overflow"
        );
        return int128(val << 64);
    }

    /**
        Convert Q64.64 fixed to signed int format.
        Rounds down.
     */
    function qtoi(int128 val)
        internal
        pure
        returns (int256)
    {
        return int64(val >> 64); // Shift out decimals, rounding down.
    }

    /**
        Convert unsigned int to Q64.64 fixed point format.
        Revers if value overflows signed 64b.
     */
    function uitoq(uint256 val)
        internal
        pure
        returns (int128)
    {
        require(
            val <= uint256(MAX_64), // TODO: check if MAX64 is still a constant.
            "Overflow"
        );
        return int128(val << 64); // Set decimals to 0 by shifting left.
    }


    /**
        Convert Q64.64 fixed point to unsigned int format.
        Rounds down.
        Reverts on overflow.
     */
    function qtoui(int128 val)
        internal
        pure
        returns (uint256)
    {
        require(
            val >= 0, // Minimal value for unsinged is 0.
            "Overflow" // TODO: use code instead of message?
        );
        return uint64(val >> 64); // Shift out decimals, rounding down.
    }

    /**
        Add two Q64.64 numbers.
        Reverts on overflow.
     */
    function add(
        int128 a,
        int128 b
    )
        internal
        pure
        returns (int128)
    {
        int256 result = int256(a) + b; // Result buffer must be int256 to capture overflows.

        require(
            result >= MIN_128 && result <= MAX_128,
            "Overflow" // TODO: use code instead of message?
        );
        return int128(result);
    }

    /**
        Substract two Q64.64 numbers.
        Reverts on overflow.
     */
    function sub(
        int128 a,
        int128 b
    )
        internal
        pure
        returns (int128)
    {
        int256 result = int256(a) - b; // Result buffer must be int256 to capture overflows.

        require(
            result >= MIN_64 && result <= MAX_64,
            "Overflow" // TODO: use code instead of message?
        );
        return int128(result);
    }

    /**
        Multiply two Q64.64 numbers.
        Revert on overflow.
     */
    function mul(
        int128 a,
        int128 b
    )
        internal
        pure
        returns (int128)
    {
        int256 result = int256(a) * b >> 64;

        require(
            result >= MIN_64 && result <= MAX_64,
            "Overflow" // TODO: use code instead of message?
        );

        return int128(result);
    }

    /**
        Divide two Q64.64 numbers.
        Rounds towards 0.
        Revert on overflow or when dividing by 0.
     */
    function div(
        int128 a,
        int128 b
    )
        internal
        pure
        returns (int128)
    {
        require(
            b != 0,
            "Divide by 0" // TODO: use code instead of message?
        );

        int256 result = int256(a) << 64 / b;

        require(
            result >= MIN_128 && result <= MAX_128,
            "Overflow"
        );
        return int128(result); // Round towards 0.
    }
}

