//众筹合约是一个募集资金的合约，在区块链上，我们是募集以太币，类似互联网业务的水滴筹。区块链早起的 ICO 就是类似业务。
// 1.需求分析
// 众筹合约分为两种角色：一个是受益人，一个是资助者。

// // 两种角色:
// //      受益人   beneficiary => address         => address 类型
// //      资助者   funders     => address:amount  => mapping 类型 或者 struct 类型
// 状态变量按照众筹的业务：
// // 状态变量
// //      筹资目标数量    fundingGoal
// //      当前募集数量    fundingAmount
// //      资助者列表      funders
// //      资助者人数      fundersKey
// 需要部署时候传入的数据:
// //      受益人
// //      筹资目标数量

// contract demo{
//     address beneficiary;
//     uint target = 20;

//     struct funders{
//         address _address;
//         uint _amount;
//     }

//     funders[] public list;
// }


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
contract CrowdFunding {
    address public immutable beneficiary;   // 受益人
    uint256 public immutable fundingGoal;   // 筹资目标数量
    uint256 public fundingAmount;       // 当前的 金额
    mapping(address=>uint256) public funders;
    // 可迭代的映射
    mapping(address=>bool) private fundersInserted;
    address[] public fundersKey; // length
    // 不用自销毁方法，使用变量来控制
    bool public AVAILABLED = true; // 状态
    // 部署的时候，写入受益人+筹资目标数量
    constructor(address beneficiary_,uint256 goal_){
        beneficiary = beneficiary_;
        fundingGoal = goal_;
    }
    // 资助
    //      可用的时候才可以捐
    //      合约关闭之后，就不能在操作了
 function contribute() external payable {
        require(AVAILABLED, "CrowdFunding is closed");

        // 检查捐赠金额是否会超过目标金额
        uint256 potentialFundingAmount = fundingAmount + msg.value;
        uint256 refundAmount = 0;

        if (potentialFundingAmount > fundingGoal) {
            refundAmount = potentialFundingAmount - fundingGoal;
            funders[msg.sender] += (msg.value - refundAmount);
            fundingAmount += (msg.value - refundAmount);
        } else {
            funders[msg.sender] += msg.value;
            fundingAmount += msg.value;
        }

        // 更新捐赠者信息
        if (!fundersInserted[msg.sender]) {
            fundersInserted[msg.sender] = true;
            fundersKey.push(msg.sender);
        }

        // 退还多余的金额
        if (refundAmount > 0) {
            payable(msg.sender).transfer(refundAmount);
        }
    }
    // 关闭
    function close() external returns(bool){
        // 1.检查
        if(fundingAmount<fundingGoal){
            return false;
        }
        uint256 amount = fundingAmount;
        // 2.修改
        fundingAmount = 0;
        AVAILABLED = false;
        // 3. 操作
        payable(beneficiary).transfer(amount);
        return true;
    }
    function fundersLenght() public view returns(uint256){
        return fundersKey.length;
    }
}