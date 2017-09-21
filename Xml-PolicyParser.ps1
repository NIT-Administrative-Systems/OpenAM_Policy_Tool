$XmlDocument = [Xml](Get-Content "realm-policies-short3.xml")

foreach ( $Policy in $XmlDocument.PolicySet.Policy) {

    # Load Root Template Xml
    $RootPolicyXML = [Xml](Get-Content "Xml-PolicyRoot.xml")

    $RootPolicyXML.PolicySet.AppendChild($RootPolicyXML.ImportNode($Policy, $true))

    $CurrentPath = Convert-Path .

    # Remove special characters
    $RegExPattern = '[^a-zA-Z]'
    $FileNameClean = $Policy.GetAttribute("PolicyId") -replace $RegExPattern, "_"

    $FilePath = Join-Path $CurrentPath $FileNameClean

    Write-Output ($FilePath + ".xml")
    
    $RootPolicyXML.OuterXml | Out-File -FilePath ($FilePath + ".xml")

}

