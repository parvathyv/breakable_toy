class Huntsplayeduser < ActiveRecord::Base

  has_many :hunts
  has_and_belongs_to_many :users

  def self.hunt_check(qno, hunt_id)

    where("question_no <= ? and hunt_id=?", qno, hunt_id).last

  end

  def self.if_exists?(hunt_id, usid)

    where("hunt_id=? and user_session_id=?" , hunt_id, usid)
  end


end
