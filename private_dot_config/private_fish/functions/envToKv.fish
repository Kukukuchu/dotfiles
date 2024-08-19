function envToKv
  set -l kvName $argv[1]
  set -l prefix $argv[2]
  echo "Deleting secrets from key vault $kvName"
  echo "Prefix: $prefix"
  for line in (cat '.env' | grep -v -e '^[[:space:]]*$' -e '^#')
    set -l keyValue (string split -m 1 = $line)
    set -l secretName (echo $keyValue[1] | sd '_' -- '-' )

    if test -n "$prefix"
      set secretName "$prefix-$secretName"
    end

    if test -n "$secretName" -a -n "$keyValue[2]"
      echo "Updating $secretName"
      az keyvault secret set --name $secretName --vault-name $kvName --value $keyValue[2]
    else
      echo "Skiping $keyValue[1]"
    end
  end 
end
