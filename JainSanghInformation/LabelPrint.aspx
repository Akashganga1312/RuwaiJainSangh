<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LabelPrint.aspx.cs" Inherits="JainSanghInformation.LabelPrint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/js/select2.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-beta.1/js/select2.min.js"></script>

    <div class="container mt-4">
        <h2 class="text-center">Filter Data & Print Address Labels</h2>
        <div class="row">
            <div class="col-md-4">
                <label>Sangh Name</label>
                <select id="ddlSanghName" class="form-control multiselect" runat="server" multiple="true" onchange="populateVillageDropdown()"></select>
            </div>
            <div class="col-md-4">
                <label>Village Name</label>
                <select id="ddlVillageName" class="form-control multiselect"  runat="server" multiple="true"></select>
            <asp:HiddenField ID="hfSelectedVillages" runat="server" />
            </div>
            <div class="col-md-4">
                <label>Member Type</label>
                <select id="ddlMemberType" class="form-control multiselect"  runat="server" multiple="true"></select>
            </div>
        </div>
        <div class="mt-3 text-center">
            <asp:Button ID="btnShowData" runat="server" CssClass="btn btn-primary" Text="Show Data" OnClick="btnShowData_Click" />
            <asp:Button ID="btnPrintLabels" runat="server" CssClass="btn btn-success" Text="Print Address Labels" OnClick="btnPrintLabels_Click" />
        </div>
        <table id="DataTable" class="display nowrap table table-bordered table-hover" style="width:100%">
    <thead>
        <tr>
            <th>Sangh Name</th>
            <th>Member Name</th>
            <th>Parent Member Name</th>
            <th>Member Type</th>
            <th>Address</th>
            <th>Village Name</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>

    </div>

    
    <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
    <script>

        $(document).ready(function () {
            $('.multiselect').select2({ placeholder: 'Select Options' });
            
        });

        function populateDataTable(data) {
            if ($.fn.DataTable.isDataTable('#DataTable')) {
                $('#DataTable').DataTable().destroy();
            }
            $('#DataTable tbody').empty();
            data.forEach(row => {
                $('#DataTable tbody').append(`
            <tr>
                <td>${row.SanghName}</td>
                <td>${row.MemberName}</td>
                <td>${row.ParentMemberName}</td>
                <td>${row.MemberType}</td>
                <td>${row.Address}</td>
                <td>${row.VillageName}</td>
            </tr>
        `);
            });
            // Initialize DataTable
            $('#DataTable').DataTable({
                scrollX: true,
                dom: 'Bfrtip',
                buttons: [],
                pageLength: 10,
            });

            populateVillageDropdown();
        }

        function populateVillageDropdown() {
            let selectedSangh = $('#<%= ddlSanghName.ClientID %>').val();
            if (selectedSangh) {
                $.ajax({
                    url: 'LabelPrint.aspx/GetVillagesBySangh',
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ sanghIds: selectedSangh }),
                    success: function (response) {
                        const villages = response.d;
                        const ddlVillageName = $('#<%= ddlVillageName.ClientID %>');

                        let previouslySelected = $('#<%= hfSelectedVillages.ClientID %>').val();
                        let selectedValues = previouslySelected ? previouslySelected.split(",") : [];


                        ddlVillageName.empty(); // Clear the dropdown options

                        // Populate dropdown with the response data
                        $.each(villages, function (index, item) {
                            let option = new Option(item.Text, item.Value);
                            ddlVillageName.append(option);

                            // Pre-select the item if it was previously selected
                            if (selectedValues.includes(item.Value)) {
                                $(option).prop('selected', true);
                            }
                        });

                        ddlVillageName.trigger('change'); // Trigger a change event after populating

                        // Handle selection changes in the dropdown
                        ddlVillageName.on('change', function () {
                            let selectedDropdownValues = ddlVillageName.val(); // Get selected options as an array

                            if (selectedDropdownValues && selectedDropdownValues.includes("All")) {
                                // If "All" is selected, clear the filter (reset hidden field)
                                $('#<%= hfSelectedVillages.ClientID %>').val("");
                            } else {
                        // Save selected values as a comma-separated string in the hidden field
                            let commaSeparatedValues = selectedDropdownValues ? selectedDropdownValues.join(",") : "";
                                $('#<%= hfSelectedVillages.ClientID %>').val(commaSeparatedValues);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        console.log('Error:', error);
                    }
                });
            }
        }


    </script>
</asp:Content>
