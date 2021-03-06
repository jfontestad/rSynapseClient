.setUp <-
  function()
{
  synapseClient:::.setCache('oldWarn', options('warn')[[1]])
  options(warn=2)

  ## create a project
  project <- createEntity(Project())
  synapseClient:::.setCache("testProject", project)

  synapseClient:::.setCache("oldCacheDir", synapseCacheDir())
  synapseCacheDir(tempfile(pattern="tempSynapseCache"))
}

.tearDown <-
  function()
{

	{project<-synapseClient:::.getCache("testProject")
		synRestDELETE(sprintf("/entity/%s?skipTrashCan=true", propertyValue(project, "id")))}
  synapseClient:::.deleteCache("testProject")

  unlink(synapseCacheDir(), recursive=T)
  synapseCacheDir(synapseClient:::.getCache("oldCacheDir"))

  options(warn=synapseClient:::.getCache("oldWarn"))
  synapseClient:::.deleteCache("oldWarn")
}


