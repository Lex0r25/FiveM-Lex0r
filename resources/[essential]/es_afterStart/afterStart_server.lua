require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "Perreo", "CiudadSexy", "Anomames")

AddEventHandler('onResourceStart', function(resource)
  MySQL:executeQuery("UPDATE user_vehicle SET `vehicle_state`='@value' WHERE `vehicle_state`='Sortit'",
  {['@value'] = "Rentré"})
end)
