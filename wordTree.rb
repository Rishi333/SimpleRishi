class WordTree

  @wordTree

  def initialize(tree = Hash.new)
    @wordTree=tree 
    @wordTree["response"] = ""
  end

  def learn(words, response)
    # need to add check to not learn anything with response keyword
    response = response.concat(" ")
    words=words.split(/\W+/)
    tree = @wordTree
    words.each do |word|
      if tree.has_key?(word) then
        tree=tree[word]
      else
        tree[word] = Hash.new
        tree = tree[word]
      end
    end
    puts "Learned that #{words} means \"#{response}\""
    tree["response"]= response
    
  end

  def respond(text)
    ##verify that text does not include response
    words = text.split(/\W+/)
    tree = @wordTree
    words.each do |word|
      if tree.has_key?(word)
        tree = tree[word]
      else
        return ""
      end
    end
    if tree["response"].nil? then return "" end
    return tree["response"]
  end

  def answer(text)
    if text.nil? then return "" end
    if text == "" then return "" end
    sucess = false
    initialText = text.clone
    leftover = ""
    response = ""
    
    while !sucess
      response = respond(text).clone
      if response == "" then
        leftover = leftover.prepend(text.split.last.concat(" "))
        text = text[/(.*)\s/,1]# break off the last word
        if text == "" || text.nil? then 
          return answer(initialText[/(?<=\s).*/])# break off the first word
        end
      else
        sucess = true;
      end
    end
    return response.concat(answer(leftover).prepend(" "))
  end

  def getTree
    return @wordTree
  end
  
end
