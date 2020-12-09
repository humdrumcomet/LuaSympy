function setupSympy(optsTable)
    varCall = optsTable.varName or 'var'
    eqtCall = optsTable.eqtName or 'eqt'
    pyEqt = pg[eqtCall]
    pyVar = pg[varCall]
    addGlFromTable(pyVar)
    addGlFromTable(pyEqt)
    addEqtFromTable(pyEqt)
end

function addEqtFromTable(eqTable)
    for key, value in itPyPair(eqTable) do
        newEqt(value.eqtType, key, value.finTex, value.initTex, value.interTex)
    end
end

function addGlFromTable(glTable)
    for key, value in itPyPair(glTable) do
        local inputsTbl = {
            name = key,
            display = value.display,
            description = value.description,
            kind = value.glsType or 'sym',
            ensureMath = value.ensureMath
        }
        if inputsTbl.ensureMath then
            inputsTbl.display = [[\ensuremath{]]..inputsTbl.display..[[}]]
        end
        if inputsTbl.description then
            newGl(inputsTbl.kind, key, inputsTbl)
        end
    end
end
