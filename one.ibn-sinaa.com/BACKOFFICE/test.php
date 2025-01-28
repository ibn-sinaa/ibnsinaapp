<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DataTables avec LocalStorage</title>
    <!-- CSS DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">
    <!-- CSS Select2 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
</head>
<body>

<h2>Ajouter des Données</h2>
<input type="text" id="name" placeholder="Name">
<input type="text" id="position" placeholder="Position">
<input type="text" id="office" placeholder="Office">
<input type="text" id="age" placeholder="Age">
<input type="text" id="startDate" placeholder="Start Date">
<input type="text" id="salary" placeholder="Salary">
<button onclick="addData()">Add</button>

<table id="example" class="display" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>Select</th>
            <th>Name</th>
            <th>Position</th>
            <th>Office</th>
            <th>Age</th>
            <th>Start Date</th>
            <th>Salary</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tfoot>
        <tr>
            <th>Select</th>
            <th>Name</th>
            <th>Position</th>
            <th>Office</th>
            <th>Age</th>
            <th>Start Date</th>
            <th>Salary</th>
            <th>Actions</th>
        </tr>
    </tfoot>
    <tbody>
    </tbody>
</table>

<!-- JS jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- JS DataTables -->
<script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
<!-- JS Select2 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

<script>
$(document).ready(function() {
    let table = $('#example').DataTable({
        initComplete: function() {
            this.api().columns().every(function() {
                var column = this;
                var select = $('<select class="mymsel" multiple="multiple"><option value=""></option></select>')
                    .appendTo($(column.footer()).empty())
                    .on('change', function() {
                        var vals = $('option:selected', this).map(function(index, element) {
                            return $.fn.dataTable.util.escapeRegex($(element).val());
                        }).toArray().join('|');
                        column.search(vals.length > 0 ? '^(' + vals + ')$' : '', true, false).draw();
                    });
                column.data().unique().sort().each(function(d, j) {
                    select.append('<option value="' + d + '">' + d + '</option>')
                });
            });
            $(".mymsel").select2();
        }
    });

    // Charger les données du localStorage
    if (localStorage.getItem('tableData')) {
        let storedData = JSON.parse(localStorage.getItem('tableData'));
        storedData.forEach(row => table.row.add(row).draw());
    }

    // Ajouter des données
    window.addData = function() {
        let data = [
            '<input type="checkbox" class="selectRow">',
            $('#name').val(),
            $('#position').val(),
            $('#office').val(),
            $('#age').val(),
            $('#startDate').val(),
            $('#salary').val(),
            '<button class="btn btn-danger btn-sm deleteBtn">Delete</button>'
        ];
        table.row.add(data).draw();
        saveDataToLocalStorage();
        clearInputFields();
    };

    // Supprimer les lignes sélectionnées
    $('#example tbody').on('click', '.deleteBtn', function() {
        table.row($(this).parents('tr')).remove().draw();
        saveDataToLocalStorage();
    });

    // Sauvegarder les données dans le localStorage
    function saveDataToLocalStorage() {
        let tableData = table.rows().data().toArray();
        localStorage.setItem('tableData', JSON.stringify(tableData));
    }

    // Fonction pour effacer les champs de saisie
    function clearInputFields() {
        $('#name').val('');
        $('#position').val('');
        $('#office').val('');
        $('#age').val('');
        $('#startDate').val('');
        $('#salary').val('');
    }
});
</script>
</body>
</html>
