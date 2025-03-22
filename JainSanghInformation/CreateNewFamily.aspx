<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateNewFamily.aspx.cs" Inherits="JainSanghInformation.CreateNewFamily" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .btn-primary {
            background-color: #4e73df;
            border: none;
            transition: background-color 0.3s ease;
        }

            .btn-primary:hover {
                background-color: #3751ab;
            }

        .form-control:focus {
            border-color: #4e73df;
            box-shadow: 0 0 5px rgba(78, 115, 223, 0.5);
        }

        .form-label {
            margin-left: 0px;
        }

        .form-control {
            border: 1px solid !important;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 16px;
            margin-left: 0px;
            margin-right: 15px;
            transition: box-shadow 0.3s ease, border-color 0.3s ease;
        }

        .table td, .table th {
            white-space: nowrap; /* Prevent text from wrapping */
        }

        .table input, .table select {
            min-width: 120px; /* Ensure input fields have a minimum width */
            max-width: 100%; /* Prevent fields from exceeding their container */
            width: auto; /* Allow input fields to adjust based on content */
        }

        .table .form-control {
            padding: 5px; /* Reduce padding for better fitting in narrow cells */
            font-size: 14px; /* Adjust font size for better visibility */
        }

        @media (max-width: 768px) {
            .table-responsive {
                overflow-x: auto; /* Enable horizontal scroll for small screens */
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="page-header">
        <h3 class="page-title">Add Family</h3>
    </div>
    <div class="card">
        <div class="card-body">
            <h4>Family Head Details</h4>
            <div class="row">
                <div class="col-md-4">
                    <label class="form-label">Family Head Name<span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtFamilyHeadName" runat="server" CssClass="form-control" placeholder="Enter Family Head Name"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Sangh<span style="color: red;">*</span></label>
                    <asp:DropDownList ID="ddlsangh" CssClass="form-control" autocompletemode="Suggest" runat="server" required="required"></asp:DropDownList>
                </div>
                             <div class="col-md-4">
    <label class="form-label">Gender<span style="color: red;">*</span></label>
    <asp:DropDownList ID="ddlFamilyHeadGender" runat="server" CssClass="form-control">
        <asp:ListItem Value="Male">Male</asp:ListItem>
        <asp:ListItem Value="Female">Female</asp:ListItem>
        <asp:ListItem Value="Other">Other</asp:ListItem>
    </asp:DropDownList>
</div>
                <div class="col-md-4">
                    <label class="form-label">Address<span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtFamilyHeadAddress" runat="server" CssClass="form-control" placeholder="Enter Address"></asp:TextBox>
                </div>
    <div class="col-md-4">
        <label class="form-label">Birthdate<span style="color: red;">*</span></label>
         <input type="date" id="txtFamilyHeadBirthdate" class="form-control" placeholder="Enter Birthdate">
    </div>
    <div class="col-md-4">
        <label class="form-label">Education</label>
        <asp:TextBox ID="txtFamilyHeadEducation" runat="server" CssClass="form-control" placeholder="Enter Education"></asp:TextBox>
    </div>
    <div class="col-md-4">
        <label class="form-label">Marriage Status</label>
        <asp:TextBox ID="txtFamilyHeadMarriageStatus" runat="server" CssClass="form-control" placeholder="Enter Marriage Status"></asp:TextBox>
    </div>
                <div class="col-md-4">
                    <label class="form-label">Occupation</label>
                    <asp:TextBox ID="txtFamilyHeadOccupation" runat="server" CssClass="form-control" placeholder="Enter Occupation"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Occupation Address</label>
                    <asp:TextBox ID="txtFamilyHeadOccupationAddress" runat="server" CssClass="form-control" placeholder="Enter Occupation Address"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Village Name<span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtFamilyHeadVillage" runat="server" CssClass="form-control" placeholder="Enter Village Name"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Primary Mobile Number<span style="color: red;">*</span></label>
                    <asp:TextBox ID="txtFamilyHeadMobile1" runat="server" CssClass="form-control" placeholder="Enter Primary Mobile Number"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Secondary Mobile Number</label>
                    <asp:TextBox ID="txtFamilyHeadMobile2" runat="server" CssClass="form-control" placeholder="Enter Secondary Mobile Number"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Email</label>
                    <asp:TextBox ID="txtFamilyHeadEmail" runat="server" CssClass="form-control" placeholder="Enter Email"></asp:TextBox>
                </div>
                  <div class="col-md-4">
        <label class="form-label">Blood Group</label>
        <asp:DropDownList ID="ddlFamilyHeadBloodGroup" runat="server" CssClass="form-control">
            <asp:ListItem Value="A+">A+</asp:ListItem>
            <asp:ListItem Value="A-">A-</asp:ListItem>
            <asp:ListItem Value="B+">B+</asp:ListItem>
            <asp:ListItem Value="B-">B-</asp:ListItem>
            <asp:ListItem Value="O+">O+</asp:ListItem>
            <asp:ListItem Value="O-">O-</asp:ListItem>
            <asp:ListItem Value="AB+">AB+</asp:ListItem>
            <asp:ListItem Value="AB-">AB-</asp:ListItem>
        </asp:DropDownList>
    </div>
            </div>
            <hr />
            <h4>Family Members</h4>
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th>Member Name</th>
                            <th>Gender</th>
                            <th>Birthdate</th>
                            <th>Relation to Head</th>
                            <th>Education</th>
                            <th>Marriage Status</th>
                            <th>Occupation</th>
                            <th>Address</th>
                            <th>Occupation Address</th>
                            <th>Village Name</th>
                            <th>Primary Mobile Number</th>
                            <th>Secondary Mobile Number</th>
                            <th>Email</th>
                            <th>Blood Group</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="membersTableBody">
                    </tbody>
                </table>
                <div class="d-flex justify-content-end">
                    <button type="button" id="btnAddMember" class="btn btn-xs btn-outline-primary">Add Member</button>
                </div>
            </div>
            <hr />
            <div class="form-group text-center">
                 <button id="btnSaveFamily" type="button" class="btn btn-primary">Save Family</button>
            </div>
        </div>
    </div>

    <asp:DropDownList ID="hiddenRelationDropdown" runat="server" CssClass="form-control" Style="display: none;">
    </asp:DropDownList>

    <script>
        const familyHeadAddress = document.getElementById('<%= txtFamilyHeadAddress.ClientID %>');
        const familyHeadVillage = document.getElementById('<%= txtFamilyHeadVillage.ClientID %>');
        const familyHeadOccupationAddress = document.getElementById('<%= txtFamilyHeadOccupationAddress.ClientID %>');
        const familyHeadMobile1 = document.getElementById('<%= txtFamilyHeadMobile1.ClientID %>');
        const familyHeadMobile2 = document.getElementById('<%= txtFamilyHeadMobile2.ClientID %>');
        const familyHeadEmail = document.getElementById('<%= txtFamilyHeadEmail.ClientID %>');

        document.addEventListener('DOMContentLoaded', function () {
            const btnSaveFamily = document.getElementById('btnSaveFamily');

            if (btnSaveFamily) {
                btnSaveFamily.addEventListener('click', function () {
                    const familyHeadName = document.getElementById('<%= txtFamilyHeadName.ClientID %>');
                    const familyHeadSangh = document.getElementById('<%= ddlsangh.ClientID %>');
                    const familyHeadSanghVak = familyHeadSangh.value;
                    const familyHeadAddress = document.getElementById('<%= txtFamilyHeadAddress.ClientID %>');
            const familyHeadVillage = document.getElementById('<%= txtFamilyHeadVillage.ClientID %>');
            const familyHeadMobile1 = document.getElementById('<%= txtFamilyHeadMobile1.ClientID %>');
            const familyHeadBirthdate = document.getElementById('txtFamilyHeadBirthdate'); // Plain input[type="date"]
                    const familyHeadEmail = document.getElementById('<%= txtFamilyHeadEmail.ClientID %>');


                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    const internationalMobileRegex = /^\+?[1-9]\d{1,14}$/;

                    if (
                        !familyHeadName.value.trim() ||
                        !familyHeadSangh.value.trim() ||
                        !familyHeadAddress.value.trim() ||
                        !familyHeadVillage.value.trim() ||
                        !familyHeadMobile1.value.trim() ||
                        familyHeadSanghVak === "--Select Item--" ||
                        !familyHeadBirthdate.value ||
                        (familyHeadEmail.value.trim() && !emailRegex.test(familyHeadEmail.value.trim())) ||
                        !internationalMobileRegex.test(familyHeadMobile1.value.trim())
                    ) {
                        showErrorNotification("Please fill all required fields of Family Head before saving.");
                        if (!familyHeadName.value.trim()) familyHeadName.focus();
                        else if (!familyHeadAddress.value.trim()) familyHeadAddress.focus();
                        else if (!familyHeadVillage.value.trim()) familyHeadVillage.focus();
                        else if (!familyHeadMobile1.value.trim() || !internationalMobileRegex.test(familyHeadMobile1.value.trim())) {
                            showErrorNotification("Please enter a valid international mobile number or.");
                            familyHeadMobile1.focus();
                        } else if (familyHeadSanghVak === "--Select Item--") familyHeadSangh.focus();
                        else if (!familyHeadBirthdate.value) {
                            showErrorNotification("Please enter a valid birthdate.");
                            familyHeadBirthdate.focus();
                        } else if (familyHeadEmail.value.trim() && !emailRegex.test(familyHeadEmail.value.trim())) {
                            showErrorNotification("Please enter a valid email address.");
                            familyHeadEmail.focus();
                        }
                        return false;
                    }

                    // If all validations pass, notify success
                    const members = document.querySelectorAll('#membersTableBody tr');
                    if (members.length > 0) {
                        for (const [index, row] of members.entries()) {
                            const memberName = row.querySelector('input[name="memberName[]"]');
                            const memberGender = row.querySelector('select[name="memberGender[]"]');
                            const memberBirthdate = row.querySelector('input[name="memberBirthdate[]"]');

                            if (
                                !memberName.value.trim() ||
                                !memberGender.value.trim() ||
                                !memberBirthdate.value.trim()
                            ) {
                                showErrorNotification(`Please fill all required fields for Family Member ${index + 1}.`);
                                if (!memberName.value.trim()) memberName.focus();
                                else if (!memberGender.value.trim()) memberGender.focus();
                                else if (!memberBirthdate.value.trim()) memberBirthdate.focus();
                                return false;
                            }
                        }
                    }

                    // If all validations pass, proceed with form submission
                    const familyHead = {
                         name: document.getElementById('<%= txtFamilyHeadName.ClientID %>').value.trim(),
                        sanghName: document.getElementById('<%= ddlsangh.ClientID %>').value,
                         gender: document.getElementById('<%= ddlFamilyHeadGender.ClientID %>').value,
                         birthdate: document.getElementById('txtFamilyHeadBirthdate').value, // Plain input[type="date"]
                         education: document.getElementById('<%= txtFamilyHeadEducation.ClientID %>').value.trim(),
                         marriageStatus: document.getElementById('<%= txtFamilyHeadMarriageStatus.ClientID %>').value.trim(),
                         address: document.getElementById('<%= txtFamilyHeadAddress.ClientID %>').value.trim(),
                         occupation: document.getElementById('<%= txtFamilyHeadOccupation.ClientID %>').value.trim(),
                         occupationAddress: document.getElementById('<%= txtFamilyHeadOccupationAddress.ClientID %>').value.trim(),
                         villageName: document.getElementById('<%= txtFamilyHeadVillage.ClientID %>').value.trim(),
                         mobile1: document.getElementById('<%= txtFamilyHeadMobile1.ClientID %>').value.trim(),
                         mobile2: document.getElementById('<%= txtFamilyHeadMobile2.ClientID %>').value.trim(),
                         email: document.getElementById('<%= txtFamilyHeadEmail.ClientID %>').value.trim(),
                         bloodGroup: document.getElementById('<%= ddlFamilyHeadBloodGroup.ClientID %>').value,
                    };

                    console.log('Family Head Data:', familyHead);


                    const familyMembers = Array.from(document.querySelectorAll('#membersTableBody tr')).map(row => ({
                        name: row.querySelector('input[name="memberName[]"]').value.trim(),
                        gender: row.querySelector('select[name="memberGender[]"]').value,
                        birthdate: row.querySelector('input[name="memberBirthdate[]"]').value,
                        relation: row.querySelector('select[name="memberRelation[]"]').selectedOptions[0].text,
                        education: row.querySelector('input[name="memberEducation[]"]').value.trim(),
                        marriageStatus: row.querySelector('input[name="memberMarriageStatus[]"]').value.trim(),
                        mobile1: row.querySelector('input[name="memberMobile1[]"]').value.trim(),
                        mobile2: row.querySelector('input[name="memberMobile2[]"]').value.trim(),
                        address: row.querySelector('input[name="memberAddress[]"]').value.trim(),
                        occupation: row.querySelector('input[name="memberOccupation[]"]').value.trim(),
                        occupationAddress: row.querySelector('input[name="memberOccupationAddress[]"]').value.trim(),
                        villageName: row.querySelector('input[name="memberVillage[]"]').value.trim(),
                        bloodGroup: row.querySelector('select[name="memberBloodGroup[]"]').value,
                        email: row.querySelector('input[name="memberEmail[]"]').value.trim(),
                    }));




                    $.ajax({
                        url: 'CreateNewFamily.aspx/SaveFamily',
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        data: JSON.stringify({ familyData: { familyHead, familyMembers } }), // Wrap data in 'familyData'
                        dataType: 'json',
                        success: function (response) {
                            const data = response.d ? JSON.parse(response.d) : response; // Parse response if necessary
                            if (data.success) {
                                showSuccessNotification(data.message);
                                location.reload();
                            } else {
                                showErrorNotification(data.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('AJAX Error:', xhr.responseText); // Log server response for debugging
                            showErrorNotification('An error occurred while saving data: ' + xhr.status + ' ' + error);
                        },
                    });

                });
            }
        });

        document.getElementById('btnAddMember').addEventListener('click', function () {
            const familyHeadName = document.getElementById('<%= txtFamilyHeadName.ClientID %>');
            const familyHeadSangh = document.getElementById('<%= ddlsangh.ClientID %>');
            const familyHeadAddress = document.getElementById('<%= txtFamilyHeadAddress.ClientID %>');
            const familyHeadVillage = document.getElementById('<%= txtFamilyHeadVillage.ClientID %>');

            // Check if Family Head required fields are filled
            if (
                !familyHeadName.value.trim() ||
                !familyHeadSangh.value.trim() ||
                !familyHeadAddress.value.trim() ||
                !familyHeadVillage.value.trim() ||
                !familyHeadMobile1.value.trim()
            ) {
                showErrorNotification("Please fill all required fields of Family Head before adding Family Members.");
                if (!familyHeadName.value.trim()) familyHeadName.focus();
                else if (!familyHeadSangh.value.trim()) familyHeadSangh.focus();
                else if (!familyHeadAddress.value.trim()) familyHeadAddress.focus();
                else if (!familyHeadVillage.value.trim()) familyHeadVillage.focus();
                else if (!familyHeadMobile1.value.trim()) familyHeadMobile1.focus();
                return;
            }

            const tbody = document.getElementById('membersTableBody');

            const existingRows = tbody.querySelectorAll('tr');

            for (const [index, row] of existingRows.entries()) {
                const memberName = row.querySelector('input[name="memberName[]"]');
                const memberGender = row.querySelector('select[name="memberGender[]"]');
                const memberBirthdate = row.querySelector('input[name="memberBirthdate[]"]');

                if (
                    !memberName.value.trim() ||
                    !memberGender.value.trim() ||
                    !memberBirthdate.value.trim() 
                ) {
                    showErrorNotification(`Please fill all required fields for Family Member ${index + 1}.`);
                    if (!memberName.value.trim()) memberName.focus();
                    else if (!memberGender.value.trim()) memberGender.focus();
                    else if (!memberBirthdate.value.trim()) memberBirthdate.focus();
                    return;
                }
            }

            const newRow = document.createElement('tr');

            const hiddenRelationDropdown = document.getElementById('<%= hiddenRelationDropdown.ClientID %>');
            const relationDropdownClone = hiddenRelationDropdown.cloneNode(true);
            relationDropdownClone.removeAttribute('id'); // Remove the ID to avoid duplicates
            relationDropdownClone.setAttribute('name', 'memberRelation[]');
            relationDropdownClone.style.display = 'block';

            newRow.innerHTML = `
                <td><input type="text" name="memberName[]" class="form-control" placeholder="Enter Member Name" required /></td>
                <td>
                    <select name="memberGender[]" class="form-control" required>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                </td>
                <td><input type="date" name="memberBirthdate[]" class="form-control" required /></td>
                <td></td> <!-- Relation dropdown will be appended here -->
                <td><input type="text" name="memberEducation[]" class="form-control" placeholder="Education" /></td>
                <td><input type="text" name="memberMarriageStatus[]" class="form-control" placeholder="Marriage Status" /></td>
                <td><input type="text" name="memberOccupation[]" class="form-control" placeholder="Occupation" /></td>
                <td><input type="text" name="memberAddress[]" class="form-control" value="${familyHeadAddress.value}" /></td>
                <td><input type="text" name="memberOccupationAddress[]" class="form-control" /></td>
                <td><input type="text" name="memberVillage[]" class="form-control" value="${familyHeadVillage.value}" /></td>
                <td><input type="text" name="memberMobile1[]" class="form-control" required  /></td>
                <td><input type="text" name="memberMobile2[]" class="form-control"  /></td>
                <td><input type="email" name="memberEmail[]" class="form-control"  /></td>
                <td>
                    <select name="memberBloodGroup[]" class="form-control">
                        <option value="A+">A+</option>
                        <option value="A-">A-</option>
                        <option value="B+">B+</option>
                        <option value="B-">B-</option>
                        <option value="O+">O+</option>
                        <option value="O-">O-</option>
                        <option value="AB+">AB+</option>
                        <option value="AB-">AB-</option>
                    </select>
                </td>
                <td><button type="button" class="btn btn-xs btn-outline-danger btnRemoveMember">Remove</button></td>
            `;

            // Append the relation dropdown to the appropriate cell
            const relationCell = newRow.children[3];
            relationCell.appendChild(relationDropdownClone);

            tbody.appendChild(newRow);

            newRow.querySelector('.btnRemoveMember').addEventListener('click', function () {
                tbody.removeChild(newRow);
            });
        });



        // Notification functions
        function showSuccessNotification(message) {
            toastr.success(message, "Success", { timeOut: 5000, closeButton: true, progressBar: true });
        }

        function showErrorNotification(message) {
            toastr.error(message, "Error", { timeOut: 5000, closeButton: true, progressBar: true });
        }

        function showInfoNotification(message) {
            toastr.info(message, "Info", { timeOut: 5000, closeButton: true, progressBar: true });
        }

        function showWarningNotification(message) {
            toastr.warning(message, "Warning", { timeOut: 5000, closeButton: true, progressBar: true });
        }
    </script>

</asp:Content>

