const express = require('express');
const app = express();
const port = 3000;

let members = [];

app.use(express.json());

app.get('/', (req,res) => {
	res.sendFile(__dirname + '/index.html');
})
app.post('/addMember', (req, res) => {
    const { address } = req.body;
    if (!members.includes(address)) {
        members.push(address);
        res.send({ message: 'Member added' });
    } else {
        res.status(400).send({ message: 'Member already exists' });
    }
});

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
