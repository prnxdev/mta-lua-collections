Collection = {}
Collection.__index = Collection

setmetatable(Collection, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Collection.new(parentTable)
    parentTable = parentTable or (parentTable == nil and {})

    local self = setmetatable({}, Collection)
    self._valuesArray = parentTable

    function self:push(value)
        table.insert(self._valuesArray, value)
        return self
    end

    function self:pop()
        table.remove(self._valuesArray)
        return self
    end

    function self:merge(...)
        local mainTable = self._valuesArray
            
        for _,table2 in ipairs({...}) do
            for key,value in pairs(table2) do
                if (type(key) == "number") then
                    table.insert(mainTable,value)
                else
                    mainTable[key] = value
                end
            end
        end

        return self
    end

    function self:where(columnName, columnValue)
        local returnArray = {}

        for key, object in ipairs(self._valuesArray) do
            if (object[columnName] == columnValue) then
                table.insert(returnArray, object)
            end
        end

        return Collection(returnArray)
    end

    function self:count()
        return #self._valuesArray
    end

    function self:at(index)
        return self._valuesArray[index]
    end

    function self:forEach(callbackFunction)
        for key, collectionElement in ipairs(self._valuesArray) do
            callbackFunction(collectionElement, key)
        end
    end

    function self:chunk(chunkIndex)
        local chunkedCollection = Collection()
        local secondaryCollection = Collection()

        self:forEach(function(collectionItem, index)
            secondaryCollection:push(collectionItem)
        
            if index % chunkIndex == 0 or index == self:count() then
                chunkedCollection:push(secondaryCollection)
                secondaryCollection = Collection()
            end
        end)

        return chunkedCollection
    end
    
    function self:filter(conditionalFunction)
      local mappedCollection = Collection()
      
      self:forEach(function(element)
        if conditionalFunction(element) then
          mappedCollection:push(element)
        end
      end)
      
      return mappedCollection
    end

    return self
end
