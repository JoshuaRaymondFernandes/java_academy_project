function set(e){

    document.getElementById("update").hidden=false;
  
}


function op() {
    var x = document.getElementById("operation").value;
    if(x=="lt" || x=="gt"){
        document.getElementById("extra").hidden=false;
        
    }
    else{
        document.getElementById("extra").hidden=true;
    }
  }
  function table() {
    var x = document.getElementById("col_name").value;
    
        document.getElementById("tab").hidden=false;
        document.getElementById("column3").innerHTML=x;
        
    
    
  }