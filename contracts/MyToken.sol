pragma solidity >=0.4.23;

contract MyToken {
    string public name;
    string public symbol;
    uint8 public decimals = 18;

    constructor(string _name, string _symbol) public {
        name = _name;
        symbol = _symbol;
        uint256 initialSupply = 1000000000 * 10 ** uint(decimals);
        balanceOf[msg.sender] = initialSupply;
        totalSupply_ = initialSupply;
    }

    event Approval(address indexed src, address indexed guy, uint wad);
    event Transfer(address indexed src, address indexed dst, uint wad);

    uint256 private totalSupply_;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    function totalSupply() public view returns (uint) {
        return totalSupply_;
    }

    function approve(address guy, uint wad) public returns (bool) {
        allowance[msg.sender][guy] = wad;
        emit Approval(msg.sender, guy, wad);
        return true;
    }

    function transfer(address dst, uint wad) public returns (bool) {
        return transferFrom(msg.sender, dst, wad);
    }

    function transferFrom(
        address src,
        address dst,
        uint wad
    ) public returns (bool) {
        require(balanceOf[src] >= wad);

        if (src != msg.sender && allowance[src][msg.sender] != uint(-1)) {
            require(allowance[src][msg.sender] >= wad);
            allowance[src][msg.sender] -= wad;
        }

        balanceOf[src] -= wad;
        balanceOf[dst] += wad;

        emit Transfer(src, dst, wad);

        return true;
    }
}
