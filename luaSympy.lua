function pgDictToTable(importLoc)
eqTab = {}
varTab = {}
python.execute([[var, eqt = lsh.getVandEfromFile(']]..importLoc..[[')
for key, value in var:
    lua.eval('eqTab['+key+']='+value)
for key, value in var:
    lua.eval('varTab['+key+']='+value)
]])
    print(type(eqTab))
    print(eqTab)
    for key, value in pairs(eqTab) do
        print(key, value)
    end
    return {varTab, eqTab}
end

function optsToTable(opts)
    print(opts)
    if opts == 'path' then
        return ''
    end
    inputs = {}
    for key, value in string.gmatch(opts, '(%w+)%s*=%s*(.*),*') do
        print(key)
        print(value)
        inputs[key] = value
    end
    return inputs
end
