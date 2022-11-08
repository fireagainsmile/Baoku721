# Baoku721

接口列表

```
    interface{

        // all events
        event TransferredSingleEdition(uint256 indexed tokenId, uint256 indexed editionId, address from, address to);
        event TransferredBatchEdition(uint256 indexed tokenId, address from, address[] to);
        event TokenIssued(uint256 indexed tokenId, uint256 amount, address indexed to);
        event FollowOnEditionsIssued(uint256 indexed tokenId, uint256 amount, address indexed to);

         // write date to  contracts
        issueProducts(uint256 _tokenId, uint256 _supply, address _to, digitalizedProductsMeta memory _dpm, string memory _tokenURI );
        issueFollowOnProducts(uint256 _tokenId, uint256 _amount);
        claimSingleEdition(uint256 _tokenId, address _to);
        claimBatchEdition(uint256 _tokenId, address[] memory _accounts);
        transferEdition(uint256 _tokenId, uint256 _editionId, address _to);
        setTokenURI(uint256 _tokenId, string memory _tokenURI);

        // get contract storage
        current(uint256 _tokenId) public view returns(uint256);
        editionBalance(address _account, uint256 _tokenId) external view returns(uint256);
        editionOwner(uint256 _tokenId, uint256 _editionId) external view returns(address);
        editionTotalSupply(uint256 _tokenId) external view returns(uint256);
        tokenMeta(uint256 _tokenId) external view returns (string memory, string memory,string memory,string memory,string memory)；
        tokenURI(uint256 tokenId) public view virtual override returns (string memory)；

}
```

## 事件

##### TransferredSingleEdition

| param name | Type    | indexed |
| ---------- | ------- | :-----: |
| tokenId    | uint256 | - [ x ] |
| editionId  | uint256 | - [ x ] |
| from       | address |  - [ ]  |
| to         | address |  - [ ]  |

##### TransferredBatchEdition

| param name | Type    | indexed |
| ---------- | ------- | :-----: |
| tokenId    | uint256 | - [ x ] |
| from       | address |  - [ ]  |
| to         | address |  - [ ]  |

##### TokenIssued

| param name | Type    | indexed |
| ---------- | ------- | :-----: |
| tokenId    | uint256 | - [ x ] |
| amount     | uint256 |  - [ ]  |
| to         | address |  - [ ]  |

##### FollowOnEditionsIssued

| param name | Type    | indexed |
| ---------- | ------- | :-----: |
| tokenId    | uint256 | - [ x ] |
| amount     | uint256 |  - [ ]  |
| to         | address |  - [ ]  |

## 写合约

##### issueProducts

该接口仅允许合约管理员调用，用于记录发售实物商品信息
caller: 合约管理员钱包地址

| Input name | Type    |                   note                   |
| ---------- | ------- | :--------------------------------------: |
| \_tokenId  | uint256 |             ERC721 token id              |
| \_supply   | uint256 |               版号发型总量               |
| \_to       | address | ERC721 所有者地址（经销商/商家钱包地址） |
| \_dpm      | tuple   |             实物商品 元数据              |
| \_tokenURI | string  |          ERC721 URI 超链接地址           |

###### digitalizedProductsMeta 数据结构如下

该数据结构为 tuple， 按照顺序依次填充以下对应数据类型

        string name; //名称
        string productId; // 商品编号
        string productType; //商品类型
        string authors; //作者
        string copyRightOwner; //版权所有人

##### issueFollowOnProducts

该接口仅允许合约管理员调用，用于记录增发实物商品信息
caller: 合约管理员钱包地址

| Input name | Type    |      note       |
| ---------- | ------- | :-------------: |
| \_tokenId  | uint256 | ERC721 token ID |
| \_amount   | uint256 |  版号增发数量   |

##### claimSingleEdition

该接口是将实物商品信息分发到单个用户地址，并按照合约逻辑分配商品附加版号， 该接口仅允许 ERC721 token 所有者 （商家钱包地址）调用  
caller: ERC721 token（实物商品）持有者钱包地址

| Input name | Type    |        note        |
| ---------- | ------- | :----------------: |
| \_tokenId  | uint256 |  ERC721 token ID   |
| \_to       | address | 商品接收者钱包地址 |

##### claimBatchEdition

该接口是将实物商品信息分发到多个用户地址，并按照合约逻辑分配商品附加版号， 该接口仅允许 ERC721 token 所有者 （商家钱包地址）调用
caller: ERC721 token（实物商品）持有者钱包地址

- note:钱包地址数量不可超过版号发行上限

| Input name | Type      |          note          |
| ---------- | --------- | :--------------------: |
| \_tokenId  | uint256   |    ERC721 token ID     |
| \_accounts | address[] | 商品接收者钱包地址列表 |

##### transferEdition

该接口用于变更对应版号商品持有人，接收者地址不能为空
caller: 版号持有者钱包地址

| Input name  | Type    |          note          |
| ----------- | ------- | :--------------------: |
| \_tokenId   | uint256 |    ERC721 token ID     |
| \_editionId | uint256 |      商品对应版号      |
| \_to        | address | 商品接收者钱包地址列表 |

##### tokenURI

更新 ERC721 描述信息
caller: 合约管理员钱包地址

| Input name | Type    |      note       |
| ---------- | ------- | :-------------: |
| \_tokenId  | uint256 | ERC721 token ID |

## 查询接口

##### current

查询实物商品当前版号

| Input name | Type    |      note       |
| ---------- | ------- | :-------------: |
| \_tokenId  | uint256 | ERC721 token ID |

| Return name | Type    |               note               |
| ----------- | ------- | :------------------------------: |
| \_editionId | uint256 | 对应 token 已经分配版到的版号 ID |

##### editionBalance

查询对应钱包持有某个特定商品数量

| Input name | Type    |          note          |
| ---------- | ------- | :--------------------: |
| \_account  | address | 实物商品持有者钱包地址 |
| \_tokenId  | uint256 |    ERC721 token ID     |

| Return name | Type    |         note         |
| ----------- | ------- | :------------------: |
| \_amount    | uint256 | 某个特定商品持有数量 |

##### editionOwner

查询对应实物商品中某个版号的所有者

| Input name  | Type    |         note          |
| ----------- | ------- | :-------------------: |
| \_tokenId   | uint256 |    ERC721 token ID    |
| \_editionId | uint256 | 实物商品中某个版号 ID |

| Return name | Type    |              note              |
| ----------- | ------- | :----------------------------: |
| \_account   | address | 某个特定商品中对应版号的所有者 |

##### editionTotalSupply

查询对应实物商品总发行量（包含初次发行以及增发）

| Input name | Type    |      note       |
| ---------- | ------- | :-------------: |
| \_tokenId  | uint256 | ERC721 token ID |

| Return name | Type    |         note         |
| ----------- | ------- | :------------------: |
| \_amount    | uint256 | 某个特定商品总发行量 |

##### tokenMeta

查询对应实物商品总发行量（包含初次发行以及增发）

| Input name | Type    |      note       |
| ---------- | ------- | :-------------: |
| \_tokenId  | uint256 | ERC721 token ID |

| Return name      | Type   |        note        |
| ---------------- | ------ | :----------------: |
| \_name           | string |    实物商品名称    |
| \_productId      | string |    实物商品 ID     |
| \_productType    | string |    实物商品类型    |
| \_authors        | string |        作者        |
| \_copyRightOwner | string | 实物商品版权所有者 |
