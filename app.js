// Load the Web3 library
window.addEventListener('load', async () => {
  if (window.ethereum) {
    // Request account access if needed
    await ethereum.request({ method: 'eth_requestAccounts' });
    window.web3 = new Web3(ethereum);
  } else {
    alert('Please install MetaMask!');
  }
});

// ABI from your deployed contract
const contractABI = [
  /* Paste your ABI here */
];

// Deployed contract address
const contractAddress = '0xYourContractAddress';

// Create a contract instance
const rewardsContract = new web3.eth.Contract(contractABI, contractAddress);

// Function to create a reward
async function createReward() {
  const memberId = document.getElementById('memberId').value;
  const rewardPoints = document.getElementById('rewardPoints').value;
  const accounts = await web3.eth.getAccounts();
  
  rewardsContract.methods.createReward(memberId, rewardPoints).send({ from: accounts[0] })
    .then(receipt => {
      alert('Reward Created!');
    })
    .catch(error => {
      console.error(error);
      alert('Error creating reward');
    });
}

// Function to get reward points of a member
async function getReward() {
  const memberId = document.getElementById('getMemberId').value;

  rewardsContract.methods.getReward(memberId).call()
    .then(result => {
      document.getElementById('rewardResult').innerText = `Reward Points: ${result}`;
    })
    .catch(error => {
      console.error(error);
      alert('Error fetching reward');
    });
}
