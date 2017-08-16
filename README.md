# MTA Lua collections

That simple class allows you to manipulate tables easier in Lua. Here's little example how powerfull this tool is.
```lua
local productsCollection = Collection()

productsCollection:push({name = "Milk", is_liquid = true})
  :push({name = "Orange juice", is_liquid = true})
  :push({name = "Hamburger", is_liquid = false})
  
--- now we wants only non liquid products so we will use 'where' method
--- and 'forEach' to output all elements from new table

productsCollection:where('is_liquid', false):forEach(function(product)
  outputConsole(product.name)
end)

--- and we get only 'Hamburger' because only this product
--- has variable 'is_liquid' set on false
```

Feel free to use and fork. I'm waiting for suggestions and also PRs :).
Now here's only small example how you can use this class. Soon I will update this README and ofc. I will add more methods.
