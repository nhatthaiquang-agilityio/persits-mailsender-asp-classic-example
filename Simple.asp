<%
	' change to address of your own SMTP server
	strHost = "smtp.gmail.com"

	If Request("Send") <> "" Then

		Set Mail = Server.CreateObject("Persits.MailSender")
		' enter valid SMTP host
		Mail.Host = strHost
		Mail.TLS = True
		Mail.Port = 587
		Mail.Username = "<Your Username SMTP>"
		Mail.Password = "<Your Password SMTP>"

		' From address
		Mail.From = Request("From")
		Mail.FromName = Request("FromName") ' optional
		Mail.AddAddress Request("To")

		' message subject
		Mail.Subject = Request("Subject")

		' message body
		Mail.Body = Request("Body")

		strErr = ""
		bSuccess = False
		On Error Resume Next ' catch errors

		' send message
		Mail.Send

		If Err <> 0 Then ' error occurred
			strErr = Err.Description
		else
			bSuccess = True
		End If
	End If
%>

<HTML>
<HEAD>
<TITLE>AspEmail: Simple.asp</TITLE>
</HEAD>
<BODY BGCOLOR="#FFFFFF">

<H2>AspEmail: Simple.asp</h2>

<% If strErr <> "" Then %>
<h3><FONT COLOR="#FF0000">Error occurred: <I><% = strErr %></I></FONT></h3>
<% End If %>

<% If bSuccess Then %>
<h3><FONT COLOR="#00A000">Success! Message sent to <% = Request("To") %>.</FONT></h3>
<% End If %>

<FORM METHOD="POST" ACTION="Simple.asp">

<TABLE CELLSPACING=0 CELLPADDING=2 BGCOLOR="#E0E0E0">
	<TR>
		<TD>Host (change as necessary in script):</TD>
		<TD><B><% = strHost %></B></TD>
	</TR>
	<TR>
		<TD>From (enter sender's address):</TD>
		<TD><INPUT TYPE="TEXT" NAME="From"></TD>
	</TR>
	<TR>
		<TD>FromName (optional, enter sender's name):</TD>
		<TD><INPUT TYPE="TEXT" NAME="FromName"></TD>
	</TR>
	<TR>
		<TD>To: (enter one recipient's address):</TD>
		<TD><INPUT TYPE="TEXT" NAME="To"></TD>
	</TR>
	<TR>
		<TD>Subject:</TD>
		<TD><INPUT TYPE="TEXT" NAME="Subject"></TD>
	</TR>
	<TR>
		<TD>Body:</TD>
		<TD><TEXTAREA NAME="Body"></TEXTAREA></TD>
	</TR>
	<TR>
		<TD COLSPAN=2><INPUT TYPE="SUBMIT" NAME="Send" VALUE="Send Message"></TD>
	</TR>

</TABLE>

</FORM>

</BODY>
</HTML>
