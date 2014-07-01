# coding: utf-8
class Advertise
  include MongoMapper::Document
  key :title, String
  key :picture, String
  key :description, String
  key :package, String
  key :state, Integer
  key :time, Integer
  key :type, Integer



  attr_accessible :title, :picture,:description,:package, :state, :time,:type
  validates :title,:length => {:maximum => 5}
  validates :title, presence: true

  ADSTATE = [
      ["未上架", 0],
      ["上架", 1],
      ["下架", 2]
  ]

  ADTYPE=[
      ["合作",0],
      ["收费",1]
  ]

  def adsite_status
    fstate = ADSTATE.find{|item| item[1] == self.state}

    fstate.nil? ? "未知" : fstate[0]
  end

  def adsite_type
    ftype = ADTYPE.find{|item| item[1] == self.type}

    ftype.nil? ? "未知" : ftype[0]
  end

  def parse_datetime
    Time.at(self.time).to_datetime
  end
end
