
require "resources/essentialmode/lib/MySQL"

MySQL:open("localhost", "Perreo", "CiudadSexy", "Anomames")



RegisterServerEvent('jobCompanies:sv_getJobId')
AddEventHandler('jobCompanies:sv_getJobId',
  function()
    TriggerClientEvent('jobCompanies:cl_setJobId', source, GetJobId(source))
  end
)

RegisterServerEvent('jobCompanies:sv_setService')
AddEventHandler('jobCompanies:sv_setService',
  function(service)
    TriggerEvent('es:getPlayerFromId', source,
      function(user)
        local executed_query = MySQL:executeQuery("UPDATE users SET enService = @service WHERE users.identifier = '@identifier'", {['@identifier'] = user.identifier, ['@service'] = service})
      end
    )
  end
)



function GetJobId(source)
  local jobId = -1

  TriggerEvent('es:getPlayerFromId', source,
    function(user)
      local executed_query = MySQL:executeQuery("SELECT identifier, job FROM users WHERE users.identifier = '@identifier' ", {['@identifier'] = user.identifier})
      local result = MySQL:getResults(executed_query, {'job'}, "identifier")

      if (result[1] ~= nil) then
        jobId = tonumber(result[1].job)
      end
    end
  )

  return tonumber(jobId)
end

