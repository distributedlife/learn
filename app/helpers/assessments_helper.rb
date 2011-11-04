module AssessmentsHelper
  def guidance_range discipline
    #get user assessments for discipline
    guidance = current_user.user_assessments.for_discipline(discipline).map {|ua| ua.guidance}.uniq.select {|ua| ua != "not assessed"}
    #sort by scale

    if guidance.count == 0
      "no assessments"
    elsif guidance.count == 1
      guidance.first
    else
      "#{guidance.first} - #{guidance.last}"
    end
  end

  def awareness_range discipline
    #get user assessments for discipline
    awareness = current_user.user_assessments.for_discipline(discipline).map {|ua| ua.awareness}.uniq.select {|ua| ua != "not assessed"}
    #sort by scale
    awareness.sort {|a,b| UserAssessments::AWARENESS.index(a) <=> UserAssessments::AWARENESS.index(b) }

    if awareness.count == 0
      "no assessments"
    elsif awareness.count == 1
      awareness.first
    else
      "#{awareness.first} - #{awareness.last}"
    end
  end
end
