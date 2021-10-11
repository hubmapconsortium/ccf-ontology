let exec    = require('child_process').exec;
let spawn   = require('child_process').spawn;
let express = require('express');
let lookup  = require('./lookup.js');
let path    = require("path");
let app     = express();

app.get('/', function(req, res){
  res.sendFile(path.join(__dirname + '/index.html'));
});

app.get('/getCellType', function(req, res) {
  let symbols = req.query.symbols || '';

  let symbol_iris = symbols.split(",")
                      .map(s => "<" + lookup.getSymbolIri(s) + ">")
                      .join(",");

  exec('sed -e "s|{{biomarkers}}|' + symbol_iris + '|g" resources/get_cell_type_from_biomarkers.sparql > /tmp/query.sparql');

  var command = spawn('robot', 
                  ['query',
                   '--tdb-directory ./.tdb',
                   '--keep-tdb-mappings true',
                   '--query /tmp/query.sparql /tmp/result.csv',
                   '&&',
                   'csvjson /tmp/result.csv'],
                  { shell: true });
  var output  = [];

  command.stdout.on('data', function(chunk) {
    output.push(chunk);
  }); 

  command.on('close', function(code) {
    if (code === 0)
      res.send(Buffer.concat(output));
    else
      res.send([]); // when the script fails, suppress it!
  });
});

app.listen(3000);