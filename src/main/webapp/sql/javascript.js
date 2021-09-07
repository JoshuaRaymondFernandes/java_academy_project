// http://localhost:8080/training_platform/CreateNewStudent?StudentName=Sakshi&Subject1=18&Subject2=79&Subject3=79

function createStudent() {

	var StudentName = document.getElementById('insertSubjectName').value;
	var Subject1 = document.getElementById('insertSub1').value;
	var Subject2 = document.getElementById('insertSub2').value;
	var Subject3 = document.getElementById('insertSub3').value;
	
	$.ajax({
		type : 'GET',
		url : '/project/CreateNewStudent',
		data : 'StudentName=' + StudentName + '&Subject1=' + Subject1 + '&Subject2=' + Subject2 + '&Subject3=' + Subject3,
		error : function(response, status, error) {
			// Gets called when an error occurs with error details in variable response
			console.log(response.responseText);
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response
			console.log("Successfully created new batch");
			getAllStudents();
		}
	});
}

function getAllStudents() {

	console.log("Get all students data");
	
	$.ajax({
		type : 'GET',
		url : '/project/FetchStudents',
		error : function(response, status, error) {
			// Gets called when an error occurs with error details in variable response
			console.log(response.responseText);
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response
			updateStudentsTable(response.data);
			updateStudentsList(response.data);
		}
	});
}


function updateStudentsTable(response) {

	var returnedData = JSON.parse(response);
	var $tableRef = $('<table class="table table-bordered">')

	// Adding the headers

	var $th = $('<tr>').append(
				$('<th class="text-center">').text("ID"),
				$('<th class="text-center">').text("Name"),
				$('<th class="text-center">').text("Subject 1"),
				$('<th class="text-center">').text("Subject 2"),
				$('<th class="text-center">').text("Subject 3"),
				$('<th class="text-center">').text("Average"),
				$('<th class="text-center">').text("Result")
			);
	$tableRef.append($th);

	$.each(returnedData, function(i, item) {
		var $tr = $('<tr>').append(
				$('<td class="text-center">').text(item.ID),
				$('<td class="text-center">').text(item.StudentName),
				$('<td class="text-center">').text(item.Subject1),
				$('<td class="text-center">').text(item.Subject2),
				$('<td class="text-center">').text(item.Subject3),
				$('<td class="text-center">').text(item.Average),
				$('<td class="text-center">').text(item.Result)
				); //.appendTo('#records_table');
		$tableRef.append($tr);
	});
	$("#records_table").html($tableRef)

}


function updateStudentsList(response) {
	var returnedData = JSON.parse(response);

	var $optionSelection = $('<select id="deleteStudentList" class="form-select" aria-label="Default select example">');
	var $optionUpdation = $('<select id="updateStudentList" class="form-select" aria-label="Default select example">');
	
	$optionSelection.append($('<option selected disabled>Select a student</option>'));
	$optionUpdation.append($('<option selected disabled>Select a student</option>'));

	$.each(returnedData, function(i, item) {
		$optionSelection.append($('<option>', {
			value : item.ID,
			text : item.StudentName
		}));
		
		$optionUpdation.append($('<option>', {
			value : item.ID,
			text : item.StudentName
		}));
		
	});
	$('#deleteStudentNamesList').html($optionSelection)
	$('#updateStudentNamesList').html($optionUpdation)
}

function deleteStudent() {

	var studentId = document.getElementById('deleteStudentList').value;

	$.ajax({
		type : 'GET',
		url : '/project/DeleteStudent',
		data : 'studentId=' + studentId,
		error : function(response, status, error) {
			// Gets called when an error occurs with error details in variable response
			console.log(response.responseText);
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response
			console.log("Successfully deleted student with ID " + studentId);
			getAllStudents();
		}
	});
}


// http://localhost:8080/project/FetchStudentByID?studentId=2

function fetchStudentDetails(){
	
	var studentId = document.getElementById("updateStudentList").value;

	console.log("Geting student data with studentID  " + studentId);
	
	$.ajax({
		type : 'GET',
		url : '/project/FetchStudentByID',
		data : 'studentId=' + studentId,
		error : function(response, status, error) {
			// Gets called when an error occurs with error details in variable response
			console.log(response.responseText);
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response
			//console.log(response.data);
			var studentData = JSON.parse(response.data)
			//console.log(studentData.StudentName);
			
			document.getElementById("updatedStudentName").value = studentData.StudentName;
			document.getElementById("updatedSub1Marks").value = studentData.Subject1;
			document.getElementById("updatedSub2Marks").value = studentData.Subject2;
			document.getElementById("updatedSub3Marks").value = studentData.Subject3;
			
			document.getElementById("update").hidden=false;
			
		}
	});
  
}

function updateStudentDetails() {
	
	var studentId = document.getElementById("updateStudentList").value;
	var updatedStudentName = document.getElementById("updatedStudentName").value;
	var updatedSub1Marks = document.getElementById("updatedSub1Marks").value;
	var updatedSub2Marks = document.getElementById("updatedSub2Marks").value;
	var updatedSub3Marks = document.getElementById("updatedSub3Marks").value;
	
	$.ajax({
		type : 'GET',
		url : '/project/UpdateStudentByID',
		data : 'studentId=' + studentId + '&updatedStudentName=' + updatedStudentName + '&updatedSub1Marks=' + updatedSub1Marks + '&updatedSub2Marks=' + updatedSub2Marks + '&updatedSub3Marks=' + updatedSub3Marks,
		error : function(response, status, error) {
			// Gets called when an error occurs with error details in variable response
			console.log(response.responseText);
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response
			console.log(response);
			getAllStudents();
		}
	});
	
	
	
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