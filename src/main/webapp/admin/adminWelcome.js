function createBatch() {

	var batchName = document.getElementById('batchName').value;
	var batchSize = document.getElementById('batchSize').value;

	$.ajax({
		type : 'POST',
		url : '/project/createBatch',
		data : 'batchName=' + batchName + '&batchSize=' + batchSize,
		error : function(response) {
			// Gets called when an error occurs with error details in variable response
			console.log("Error while calling createBatch");
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response
			console.log("Successfully created new batch");
		}
	});
}

function createSubject() {
	var subjectName = document.getElementById('subjectName').value;
	var hoursLength = document.getElementById('hoursLength').value;

	$.ajax({
		type : 'POST',
		url : '/project/CreateSubject',
		data : 'subjectName=' + subjectName + '&hoursLength=' + hoursLength,
		error : function(response) {
			// Gets called when an error occurs with error details in variable response
			console.log("Error while calling CreateSubject");
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response
			console.log("Successfully created new subject");
		}
	});
}

function createAssociate() {

	var studentID = document.getElementById('studentID').value;
	var studentName = document.getElementById('studentName').value;
	var batchSelection = document.getElementById('batchSelection').value;

	$.ajax({
		type : 'POST',
		url : '/project/CreateAssociate',
		data : 'studentID=' + studentID + '&studentName=' + studentName
				+ '&batchSelection=' + batchSelection,
		error : function(response) {
			// Gets called when an error occurs with error details in variable response
			console.log("Error while creating new students");
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response
			console.log("Successfully created new associate");
			$("#createNewStudentForm")[0].reset();
			document.getElementById('studentID').value = '';
			document.getElementById('studentName').value = '';
		}
	});
}

function fetchBatches() {

	console.log("Fetching Batches from FetchBatches");

	$.ajax({
		type : 'GET',
		url : '/project/FetchBatches',
		error : function(response) {
			// Gets called when an error occurs with error details in variable response
			console.log("this sucks now");
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response

			updateViewBatches(response.data);
			updateSelectBatches(response.data);
		}
	});
}

function deleteBatch() {

	console.log("Delete Batch from FetchBatches");
	
	var batchId = document.getElementById('batchDeletion').value;

	$.ajax({
		type : 'POST',
		url : '/project/DeleteBatch',
		data : 'batchId=' + batchId,
		error : function(request, status, error) {
			// Gets called when an error occurs with error details in variable response
			console.log(error);
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response

			console.log("Successfully deleted batch and its associates");
		}
	});
}

function fetchAssociates() {

	console.log("Fetching Associates from FetchAssociates");

	$.ajax({
		type : 'GET',
		url : '/project/FetchAssociates',
		error : function(request, status, error) {
			// Gets called when an error occurs with error details in variable response
			console.log(error);
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response

			updateViewAssociates(response.data);
		}
	});
}

function updateViewAssociates(response) {

	var returnedData = JSON.parse(response);
	var $tableRef = $('<table class="table table-bordered">')

	// Adding the headers

	var $th = $('<tr>').append($('<th class="text-center">').text("Associate ID"),
			$('<th class="text-center">').text("Name"),
			$('<th class="text-center">').text("Batch Name"));
	$tableRef.append($th);

	$.each(returnedData, function(i, item) {
		var $tr = $('<tr>').append(
				$('<td class="text-center">').text(item.studentID),
				$('<td class="text-center">').text(item.studentName),
				$('<td class="text-center">').text(item.batchName)); //.appendTo('#records_table');
		$tableRef.append($tr);
	});
	$("#associates_table").html($tableRef)

}

function updateViewBatches(response) {

	var returnedData = JSON.parse(response);
	var $tableRef = $('<table class="table table-bordered">')

	// Adding the headers

	var $th = $('<tr>').append($('<th class="text-center">').text("ID"),
			$('<th class="text-center">').text("Batch Name"),
			$('<th class="text-center">').text("Batch Size"));
	$tableRef.append($th);

	$.each(returnedData, function(i, item) {
		var $tr = $('<tr>').append(
				$('<td class="text-center">').text(item.ID),
				$('<td class="text-center">').text(item.batchName),
				$('<td class="text-center">').text(item.batchSize)); //.appendTo('#records_table');
		$tableRef.append($tr);
	});
	$("#records_table").html($tableRef)

}

function fetchSubjects() {

	console.log("Fetching Subjects from FetchSubjects");

	$.ajax({
		type : 'GET',
		url : '/project/FetchSubjects',
		error : function(request, status, error) {
			// Gets called when an error occurs with error details in variable response
			console.log(error);
		},
		success : function(response) {
			// Gets called when the action is successful with server response in variable response
			updateSelectSubjects(response.data);
		}
	});
}

function updateSelectBatches(response) {
	var returnedData = JSON.parse(response);

	var $optionSelection = $('<select id="batchSelection" class="form-select" aria-label="Default select example">');
	var $optionDeletion = $('<select id="batchDeletion" class="form-select" aria-label="Default select example">');
	var $optionTest = $('<select id="batchSelectionTest" class="form-select" aria-label="Default select example">');

	$.each(returnedData, function(i, item) {
		$optionSelection.append($('<option>', {
			value : item.ID,
			text : item.batchName
		}));
		$optionDeletion.append($('<option>', {
			value : item.ID,
			text : item.batchName
		}));
		$optionTest.append($('<option>', {
			value : item.ID,
			text : item.batchName
		}));
	});
	$('#batchSelectionSection').html($optionSelection)
	$("#batchDeletionSection").html($optionDeletion)
	$('#batchSelectionTestSection').html($optionSelection)
	
}

function updateSelectSubjects(response) {
	var returnedData = JSON.parse(response);

	var $optionSelection = $('<select id="subjectSelection" class="form-select" aria-label="Default select example">');

	$.each(returnedData, function(i, item) {
		$optionSelection.append($('<option>', {
			value : item.subjectId,
			text : item.subjectName
		}));
	});
	$('#subjectNameTest').html($optionSelection)
}
