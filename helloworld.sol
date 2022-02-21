pragma solidity ^0.4.17;

contract HelloWorld{

    //declares an unsigned integer
    uint data;

    // constructor, initialises data as 0
    constructor() public {
        data = 0;
    }

    //getter function for the unsigned integer
    function getData public view returns(uint){
        return data;
    }

    
}