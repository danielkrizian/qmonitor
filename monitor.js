function generateTableHTML(data){
    /* we will iterate through the object wrapping it in the HTML table tags */
    var tableHTML = '<table border="1"><tr>';
    for (var x in data[0]) {
        /* loop through the keys to create the table headers */
        tableHTML += '<th>' + x + '</th>';
    }
    tableHTML += '</tr>';
    for (var i = 0; i < data.length; i++) {
        /* loop through the rows, putting tags around each col value */
        tableHTML += '<tr>';
        for (var x in data[0]) {
            tableHTML += '<td>' + data[i][x] + '</td>';
        }
        tableHTML += '</tr>';
    }
    tableHTML += '</table>';
    return tableHTML;
}
