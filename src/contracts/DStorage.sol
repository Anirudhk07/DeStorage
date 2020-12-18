pragma solidity ^0.5.0;

contract DStorage {
  string public name = 'DStorage'; //statically typed public so that we can access it outside the smart contract
  uint public fileCount = 0;
  //Mapping FileId=>hashvalues
  // KEY  =1 => VALUE : 
  mapping(uint => File) public files;  //UNSIGNED int =File

//attributes of File that we need for dropbox
  struct File {
    uint fileId;
    string fileHash;
    uint fileSize;
    string fileType;
    string fileName;
    string fileDescription;
    uint uploadTime;
    address payable uploader;
  }
 
  event FileUploaded(
    uint fileId,
    string fileHash,
    uint fileSize,
    string fileType,
    string fileName, 
    string fileDescription,
    uint uploadTime,
    address payable uploader
  );

  constructor() public {
  }

  function uploadFile(string memory _fileHash, uint _fileSize, string memory _fileType, string memory _fileName, string memory _fileDescription) public {
    //corner cases !
    // Make sure the file hash exists
    require(bytes(_fileHash).length > 0);

    // Make sure file type exists
    require(bytes(_fileType).length > 0);
    
    // Make sure file description exists
    require(bytes(_fileDescription).length > 0);
    
    // Make sure file fileName exists
    require(bytes(_fileName).length > 0);
    
    // Make sure uploader address exists
    require(msg.sender!=address(0));
    
    // Make sure file size is more than 0
    require(_fileSize>0);

    // Increment file id
    fileCount ++;

    // Add File to the contract
    files[fileCount] = File(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, now, msg.sender);//send uploader address
    
    // Trigger an event 
    emit FileUploaded(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, now, msg.sender);
  }
}