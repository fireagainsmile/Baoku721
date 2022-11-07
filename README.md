# Baoku721
接口列表
```
    interface{
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