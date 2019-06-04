const { BN } = require('openzeppelin-test-helpers')

const Q64x64FixedMathMock = artifacts.require('Q64x64FixedMathMock');

contract('Q64x64FixedMath', () => {
  beforeEach(async () => {
    this.fixedMath = await Q64x64FixedMathMock.new();
  });

  const testCommutative = async (fn, lhs, rhs, expected) => {
    (await fn(lhs, rhs)).should.be.bignumber.equal(expected);
    (await fn(rhs, lhs)).should.be.bignumber.equal(expected);
  }

  it('should convert back and forth from Q64.64 fixed to signed int', async () => {
    const testVal = new BN(5);

    const back = await this.fixedMath.itoq(testVal);
    const forth = await this.fixedMath.qtoi(back);
    forth.should.be.bignumber.equal(testVal);
  });

  it('should add 5 and 7', async () => {
      const a = await this.fixedMath.itoq(new BN(5));
      const b = await this.fixedMath.itoq(new BN(7));
      const res = await this.fixedMath.itoq(new BN(12));

      await testCommutative(this.fixedMath.add, a, b, res);
  });
});