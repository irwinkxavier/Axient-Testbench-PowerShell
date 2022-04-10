#Creating a TCP Client object
$tcpClient = New-Object System.Net.Sockets.TCPClient

#Connecting to the Axient receiver (change IP Address)
$tcpClient.Connect("169.254.64.36",2202)

#Write the message to be sent
$Text = "This is a test message"

#Converting the message into bytes
[byte[]]$bytes  = [text.Encoding]::Ascii.GetBytes($Text)

#Creating a network stream to transmit the bytes
$clientStream = $tcpClient.GetStream()

#Writing the message to the device
$clientStream.Write($bytes,0,$bytes.length)

#Flush the contents in the network stream
$clientStream.Flush()

#Check if data has been sent back
$clientStream.DataAvailable

#Check how much data is available and store in bytesAvailable
[byte[]]$bytesAvailable = $tcpClient.Available

#Creating a buffer which is bytesAvailable long to store the received data
[byte[]]$inStream = New-Object byte[] $bytesAvailable

#Read the data onto the buffer
$response = $clientStream.Read($inStream, 0, $inStream.count)

#Converted received bytes to ASCII
[System.Text.Encoding]::ASCII.GetString($inStream[0..($response - 1)])

#Free up resources
$tcpClient.Dispose()
$clientStream.Dispose()