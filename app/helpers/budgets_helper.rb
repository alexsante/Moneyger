module BudgetsHelper

  class DateHelper

    attr_accessor :current_date  # Current running date
    attr_accessor :original_date # Original date pass in when class was initialized
    attr_accessor :frequency # Weekly, BiWeekly, etc..

    def initialize(start_date = Date.parse(Time.now.to_s), frequency = 'bi-weekly')
      self.current_date = start_date
      self.frequency = frequency
    end                 

    def next
      # TODO: Refactor into a case statement 
      if self.frequency.downcase == "weekly"
        next_week
      elsif self.frequency.downcase == "bi-weekly"
        next_biweek
      elsif self.frequency.downcase == "bi-monthly"
        next_bimonth
      elsif self.frequency.downcase == "quarterly"
        next_quarter
      elsif self.frequency.downcase == "monthly"
        next_month
      end
      current_date
    end

    def reset
      self.current_date= self.original_date
    end

    private
    def next_week
      self.current_date= self.current_date + 7
    end

    def next_biweek
      self.current_date= self.current_date + 14
    end

    def next_quarter
      self.current_date= self.current_date.next_month.next_month.next_month
    end

    def next_bimonth

      date = self.current_date
    
      if date == date.end_of_month
        date += 15

         # Reset to monday if new date lands on the weekend
        if date.wday == 6
          date -= 1
        elsif date.wday == 0
          date += 1
        end


      elsif date.mday == 1
        date += 14
      else
        date = date.end_of_month
      end
    
       
      self.current_date= date
    end

    def next_month
      date= self.current_date
      self.current_date= date.next_month
    end

  end

end
