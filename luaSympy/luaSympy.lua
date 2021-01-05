function setupSympy(optsTable)
    varCall = optsTable.varName or 'var'
    eqtCall = optsTable.eqtName or 'eqt'
    pyEqt = pg[eqtCall]
    pyVar = pg[varCall]
    addGlFromTable(pyVar)
    addGlFromTable(pyEqt)
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
            display = value.symbol,
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

function insertEqtFromPython(eqtName, optsTable)
    --local optsTable = optsToTable(opts)
    local procOpt = {
        full = '',
        noSub = '[-2]',
    }
    local show = optsTable.show or 'eqt'
    local procSlice = procOpt[optsTable.procSlice] or optsTable.procSlice or procOpt.full
    local calcName = optsTable.calcName or ''
    local kwargs = optsTable.kwargs or ''
    python.execute('__tempTex__ = '..eqtName..'.totex(name="'..calcName..'", '..kwargs..')')
    local eqt = pg.__tempTex__[0]
    local steps = python.eval('__tempTex__[1]'..procSlice..'[:-1]')
    local stepsEnd = python.eval('__tempTex__[1]'..procSlice..'[-1]')
    local numPrint = optsTable.numPrint or 'nochg'
    local surroundKind = optsTable.surround or 'full'
    local alignedEqt = ''

    eqKind = 'equation'
    if show == 'proc' then
        eqKind = 'align'
    end
    append = {
        nochg = '',
        nonum = [[\nonumber]],
        newLine = [[\\]],
        extraSpace = "[1em]"
    }
    surroundBegin = {
        full = [[\begin{]]..eqKind..[[}]],
        inline = [[$]]
    }
    surroundEnd = {
        full = [[\label{eqt:]]..eqtName..[[}\end{]]..eqKind..[[}]],
        inline = [[$]]

    }
    eqDisp = {
        equation = eqt,
        align = ''
    }
    local num = 0
    print('-------------printing: '..eqtName)
    for idx, i in itPyPair(steps) do
        print(idx..': '..i)
        num = idx
        eqDisp['align'] = eqDisp['align']..string.gsub(i, ' = ', ' &= ')..' '..append.nonum..append.newLine..' '
    end
    num = num+1
    print(num..': '..stepsEnd)
    eqDisp['align'] = eqDisp['align']..string.gsub(stepsEnd, ' = ', ' &= ')
    eqStr = surroundBegin[surroundKind]..eqDisp[eqKind]..append[numPrint]..surroundEnd[surroundKind]
    tex.sprint(eqStr)
end
