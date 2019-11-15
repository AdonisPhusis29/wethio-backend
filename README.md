Currently the Zynecoin development is still in progress.

Documentation for set-up rpc-client of Zyn-coin on unix based OS
https://github.com/zynecoin/wethio-backend.git

Step 1 : ​ Install Golang

Download​ ​ go1.12.12​ ​ binary for your respective Architecture from
https://golang.org/dl/

Step 2​ ​ To extract the Downloaded file
$ sudo tar -xvf filename

Step 3 ​ To move the extracted folder to path
$ sudo mv go /usr/local

Step 4 ​ Setup Go Environment
$ vim ~/.profile

To enter edit mode press
ESC + i
Go the end of the file and add these 2 lines

export GOROOT=/usr/local/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

To write to this file and exit press
ESC
then type ​ :wq! ​ and hit enter

Now source the environment file by
$ source ~/.profile

Verify go installed properly by
$ go version

Step 5​ ​ Setup the command line tools
Clone the repository
$ git clone https://github.com/zynecoin/wethio-backend.git

to build the code
$ make all
(If make all command is not running, install build-essentials)

To add path
$ export PATH=$PATH:/opt/Wethio-backend/build/bin

you need to first open zyn terminal by this command
zyn attach http://149.28.202.255:3545

1-> To create wallet here (test) is the password of account
web3.currentProvider.newAccount("test")

2-> To show balance​ (here we are passing address of the wallet)
web3.eth.getBalance("0x30e4f81e7da48122fe180aeb2a82f8e1654a9fb0")

3-> To unlock account enter above command​ (here we are passing address of the wallet)
personal.unlockAccount("0x30e4f81e7da48122fe180aeb2a82f8e1654a9fb0")
and enter password of the account

4-> To send zyn to another address​ (from is sender account and to is reciever account value is 1 zyn=100000000000000000)

4-1 First Check balance:
web3.eth.getBalance("0xb4756416edf36a62a4b94630522bdb0153f3676a") ​ (here we are passing address of
the wallet)

4-2 Unlock account:
personal.unlockAccount("0x30e4f81e7da48122fe180aeb2a82f8e1654a9fb0") ​ (here we are passing address of
the wallet)

4-3 The account you create locally is not yet recognized by the distant server to do that you
should to send some zyn to the adress you create form a recognized, we have configured this adress
“0xaa4a0902126f25fdfbae888f1d7759d98100d65f” ​ to do that , please send the minimum amount :

eth.sendTransaction({from: "0xaa4a0902126f25fdfbae888f1d7759d98100d65f
",to: "0x30e4f81e7da48122fe180aeb2a82f8e1654a9fb0", value: "1000000000000000000000"}) ​ (in
second parameter we are passing address of the wallet you created and unlock step1 and step 4-2) ​ This method will return the
Tx hash of the transaction.
4-4 To check transaction by hash :
eth.getTransaction("0xba8fae97ef0450995f6fc2756ed2da42ee40005f7e82d3365dc9bb2a1bdf0da6")
(here we are passing the tx hash returned by step 4-3)
you will see the transaction details like this
{
blockHash:
"0x0000000000000000000000000000000000000000000000000000000000000000",
blockNumber: null,
from: "0xe3ea33d333cf5dacc8f38895c0c86871ccf212c0",
gas: 90000,
gasPrice: 250000000,
hash: "0xba8fae97ef0450995f6fc2756ed2da42ee40005f7e82d3365dc9bb2a1bdf0da6",
input: "0x",
nonce: 14,
r: "0x3b00dd4bce70f493cdd6869a9db14f88acd415332232200ed4caf2ad91f7f895",
s: "0x2ab544c76e7475f61100ff0a21de1719f64d6e75e64984ec90a74b63ca29377d",
to: "0x30e4f81e7da48122fe180aeb2a82f8e1654a9fb0",
transactionIndex: 0,
v: "0x3ce5",
value: 1e+21
}

PS : You can also use our faucet to send test zyn to your account :
http://dev.faucet.testnet.wethio.io/