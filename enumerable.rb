module Enumerable
    def my_each

        i = 0
        len = self.length
        loop do
            condition = true;
            yield(self[i])
            i += 1
            condition = false if i >= len
            break unless condition

        end
        self

    end
    def my_each_with_i
        i = 0
        len = self.length
        loop do
            condition = true;
            yield(self[i], i)
            i += 1
            condition = false if i >= len
            break unless condition

        end
        self
    end
    def my_select

        i = 0
        if self.class == Array
            len = self.length
            self.my_each{|value|
                yield(value)
            }
        else
            len = self.keys.length
            loop do
                condition = true;
                yield(self.keys[i], self.values[i])
                i += 1
                condition = false if i >= len
                break unless condition

            end
        end
    end

    def my_any?
        self.my_each{|value|
            return true if yield(value)
        }
        return false
    end

    def my_all?
        self.my_each{|value|
            return false unless yield(value)
        }
        return true;
    end

    def my_none?
        self.my_each{|value|
            return true unless yield(value)
        }
        return false
    end

    def my_count(repeated = nil)
        i = 0;
        if repeated == nil
            
            unless block_given?
                self.my_each{|value|
                    i += 1
                }
                i
            else
    
                self.my_each{|value|
                    i += 1 if yield(value)    
                }
                i
            end
        else
            self.my_each{|value|
                i += 1 if value == repeated
            }
            i
        end
    end

    def my_map
        arr = []
        if block_given? 
            self.my_each_with_i{|value,index|
                arr[index] = yield(value)
            }
        else
            self.my_each{|value| value}
            
        end
        arr
    end

    def my_inject(init = nil)
        if init == nil
          initialize_num = true
        elsif init.is_a?(Symbol)
          return self.my_inject{|sum, n| sum.method(init).call(n)}
        else
          sum = init
          initialize_num = false
        end
        for i in self
          if initialize_num
            sum = i
            initialize_num = false
          else
            sum = yield sum, i  
          end
        end
        sum
    end

end
