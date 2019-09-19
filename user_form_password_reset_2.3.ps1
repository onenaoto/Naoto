# パスワードリセットユーザーフォーム

# アセンブリの読み込み
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# フォームの作成
$form = New-Object System.Windows.Forms.Form 
$form.Text = "Password Reset"
$form.Size = New-Object System.Drawing.Size(260,400) 

# OKボタンの設定
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(40,300)
$OKButton.Size = New-Object System.Drawing.Size(75,30)
$OKButton.Text = "OK"
$OKButton.DialogResult = "OK"

# キャンセルボタンの設定
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(130,300)
$CancelButton.Size = New-Object System.Drawing.Size(75,30)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = "Cancel"

# ラベルの設定(SMTP Server)
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,30) 
$label.Size = New-Object System.Drawing.Size(250,20) 
$label.Text = "Please input Email server IP address."

# 入力ボックスの設定(SMTP Server)
$textBoxSMTPServer = New-Object System.Windows.Forms.TextBox 
$textBoxSMTPServer.Location = New-Object System.Drawing.Point(10,50) 
$textBoxSMTPServer.Size = New-Object System.Drawing.Size(225,50)

# SMTP Server Reminder
$textBoxSMTPServer.Text = ""

# ラベルの設定(Fromアドレス)
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,100) 
$label2.Size = New-Object System.Drawing.Size(250,20) 
$label2.Text = "Please input Email address for Target User."

# 入力ボックスの設定(Fromアドレス)
$textBoxFromAddress = New-Object System.Windows.Forms.TextBox 
$textBoxFromAddress.Location = New-Object System.Drawing.Point(10,120) 
$textBoxFromAddress.Size = New-Object System.Drawing.Size(225,50) 

# ラベルの設定(宛先アドレス)
$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(10,170) 
$label3.Size = New-Object System.Drawing.Size(250,20) 
$label3.Text = "Please select Email address for GDE server"

# 入力ボックスの設定(宛先アドレス)セレクトボックスに変更
#$textBoxToAddress = New-Object System.Windows.Forms.TextBox 
#$textBoxToAddress.Location = New-Object System.Drawing.Point(10,190) 
#$textBoxToAddress.Size = New-Object System.Drawing.Size(225,50) 

$Combo = New-Object System.Windows.Forms.Combobox
$Combo.Location = New-Object System.Drawing.Point(10,190) 
$Combo.Size = New-Object System.Drawing.Size(225,50) 

$Combo.DropDownStyle = "DropDown"
$Combo.FlatStyle = "standard"

[void] $Combo.Items.Add("aldappwd@mailbox.xx.gdx-sys.com")
[void] $Combo.Items.Add("xx-aldappwd@mailbox.x.gdx-sys.com")
[void] $Combo.Items.Add("helpdesk@xx.toyota-edc.com")


# ラベルの設定(RegID)
$label4 = New-Object System.Windows.Forms.Label
$label4.Location = New-Object System.Drawing.Point(10,240) 
$label4.Size = New-Object System.Drawing.Size(250,20) 
$label4.Text = "Please input Registered ID"

# 入力ボックスの設定(RegID)
$textBoxRegID = New-Object System.Windows.Forms.TextBox 
$textBoxRegID.Location = New-Object System.Drawing.Point(10,260) 
$textBoxRegID.Size = New-Object System.Drawing.Size(225,50) 

# キーとボタンの関係
$form.AcceptButton = $OKButton
$form.CancelButton = $CancelButton

# ボタン等をフォームに追加
$form.Controls.Add($OKButton)
$form.Controls.Add($CancelButton)
$form.Controls.Add($label) 
$form.Controls.Add($textBoxSMTPServer)
$form.Controls.Add($label2) 
$form.Controls.Add($textBoxFromAddress)
$form.Controls.Add($label3) 
$form.Controls.Add($Combo)
$form.Controls.Add($label4) 
$form.Controls.Add($textBoxRegID)

# フォームを表示させ、その結果を受け取る
$result = $form.ShowDialog()

# メール送付設定
if ($result -eq "OK")
{
$SMTPServer = $textBoxSMTPServer.Text

$emailMessage = New-Object System.Net.Mail.MailMessage
$emailMessage.From = $textBoxFromAddress.Text
$emailMessage.To.Add($Combo.Text)
$emailMessage.Subject = ""
$emailMessage.Body = "RegisteredID=" + $textBoxRegID.Text
$emailMessage.BodyEncoding = [System.Text.Encoding]::UTF8
$emailMessage.BodyTransferEncoding = [System.Net.Mime.TransferEncoding]::SevenBit

$SMTPClient = New-Object Net.Mail.SmtpClient($SMTPServer)
$SMTPClient.Send($emailMessage)

Read-Host "Please confirm any errors shown, and press Enter key to exit."


}