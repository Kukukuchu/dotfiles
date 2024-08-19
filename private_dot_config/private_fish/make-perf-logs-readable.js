const fs = require('fs');
const readline = require('readline');

const filePath = '/home/dmrp/tempprofile.txt';

const rl = readline.createInterface({
  input: fs.createReadStream(filePath),
  crlfDelay: Infinity
});

let result = [];
let stack = [];

rl.on('line', (line) => {
    if (line === '' || line.startsWith('Time')) {
      return;
    }

    const [time, sum, command] = line.split('\t');

    // how many dashes in the beginning of command
    const level = (command.match(/^(-*)/g) || [[]])[0].length;

    const item = {
      time: time.trim(),
      sum: sum.trim(),
      command: command.trim(),
      level: level
    };

    let parent = undefined;
    do {
      parent = stack.pop();
    } while (parent && parent.level >= level);
    
    if (parent) {
      if (!parent.children) {
        parent.children = [];
      }
      parent.children.push(item);
      stack.push(parent);
      stack.push(item);  
    } else {
      result.push(item);
      stack.push(item);
    }
});

rl.on('close', () => {
  console.log(JSON.stringify(result, null, 2));
});