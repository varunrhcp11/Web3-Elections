var Elections = artifacts.require("./Elections.sol");

contract("Elections", function (accounts) {
	var electionInstance;
	it("initalizes with two candidates", function(){
		return Elections.deployed().then(function(instance){
			return instance.candidatescount();
		})	.then(function(count){
			assert.equal(count, 2);
		});
	});


	it("it initalized the candidates with the correct values", function(){
		return Elections.deployed().then(function(instance){
			electionInstance = instance;
			return electionInstance.candidates(1);
		}).then(function(candidate){
			assert.equal(candidate[0], 1, "contains the correct id");
			assert.equal(candidate[1], "Candidate 1", "contains the correct name");
			assert.equal(candidate[2], 0, "contains correct vote count");
			return electionInstance.candidates(2);
		}) .then(function(candidate){
			assert.equal(candidate[0], 2, "contains the correct id");
			assert.equal(candidate[1], "Candidate 2", "contains the correct name");
			assert.equal(candidate[2], 0, "contains correct vote count");
		});
	});
});
