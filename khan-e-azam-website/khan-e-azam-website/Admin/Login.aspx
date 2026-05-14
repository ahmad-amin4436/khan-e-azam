<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="KhanEAzam.Admin.Login" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Login — Khan-E-Azam</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body { background: #1F4D2C; min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .login-card { background: #fff; border-radius: 12px; padding: 40px; width: 380px; box-shadow: 0 8px 32px rgba(0,0,0,.3); }
        .login-card .brand { text-align: center; font-size: 1.5rem; font-weight: 700; color: #1F4D2C; margin-bottom: 8px; }
        .login-card .brand span { color: #F5B82E; }
        .login-card .subtitle { text-align: center; color: #888; font-size: .9rem; margin-bottom: 28px; }
        .btn-login { background: #1F4D2C; color: #fff; width: 100%; padding: 10px; font-size: 1rem; border: none; border-radius: 6px; }
        .btn-login:hover { background: #163820; color: #fff; }
        .form-control:focus { border-color: #1F4D2C; box-shadow: 0 0 0 .2rem rgba(31,77,44,.25); }
    </style>
</head>
<body>
    <form id="frmLogin" runat="server">
        <div class="login-card">
            <div class="brand"><i class="fas fa-utensils"></i> Khan-E-<span>Azam</span></div>
            <div class="subtitle">Admin Panel Login</div>
            <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false"></asp:Label>
            <div class="form-group">
                <label>Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username" />
            </div>
            <div class="form-group">
                <label>Password</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter password" />
            </div>
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login mt-2" OnClick="btnLogin_Click" />
        </div>
    </form>
</body>
</html>
