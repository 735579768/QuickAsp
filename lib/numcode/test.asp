<%@LANGUAGE="VBSCRIPT"%>
<%
Response.CacheControl = "no-cache"
Response.AddHeader "pragma","no-cache"
Response.Expires = -1
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script type="text/javascript" language="javascript">
        function RefreshImage(valImageId) {
            var objImage = document.getElementById(valImageId)
            if (objImage == undefined) {
                return;
            }
            var now = new Date();
            objImage.src = objImage.src.split('?')[0] + '?x=' + now.toUTCString();
        }
    </script>
</head>
<body>
    <form name="form1" id="form1" method="post">
    <div style="text-align: center; margin-top: 20px;">
        <%
        if Request.ServerVariables("REQUEST_METHOD") = "POST" and IsEmpty(Request.Form("btnRetry")) then
            Dim lblResult, lblColor
            if IsEmpty(Session("ASPCAPTCHA")) or Trim(Session("ASPCAPTCHA")) = "" then
                lblResult = "This test has expired."
                lblColor = "red"
            else
                Dim TestValue : TestValue = Trim(Request.Form("txtCaptcha"))
                '//Uppercase fix for turkish charset//
                TestValue = Replace(TestValue, "i", "I", 1, -1, 1)
                TestValue = Replace(TestValue, "İ", "I", 1, -1, 1)
                TestValue = Replace(TestValue, "ı", "I", 1, -1, 1)
                '////////////////////
                TestValue = UCase(TestValue)
                
                if StrComp(TestValue, Trim(Session("ASPCAPTCHA")), 1) = 0 then
                    lblResult = "CAPTCHA PASSED"
                    lblColor = "green"
                else
                    lblResult = "CAPTCHA FAILED"
                    lblColor = "red"
                end if
                '//IMPORTANT: You must remove session value for security after the CAPTCHA test//
                Session("ASPCAPTCHA") = vbNullString
                Session.Contents.Remove("ASPCAPTCHA")
                '////////////////////
            end if
        %>
        <p><span style="color: <%=lblColor%>; font-weight: bold;"><%=lblResult%></span></p>
        <input type="submit" name="btnRetry" id="btnRetry" value="Take another test" />
        <%else%>
        <img src="captcha.asp" id="imgCaptcha" />&nbsp;<a href="javascript:void(0);" onclick="RefreshImage('imgCaptcha');">Get a new challenge</a><br />
        Write the characters in the image above<br />
        <input type="text" name="txtCaptcha" id="txtCaptcha" value="" /><br />
        <input type="submit" name="btnSubmit" id="btnSubmit" value="Submit" />
        <%end if%>
    </div>
    </form>
</body>
</html>
