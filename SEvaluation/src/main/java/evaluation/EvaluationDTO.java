package evaluation;

public class EvaluationDTO {

	int evaluationID;
	String userID;
	String countryName;
	String regionName;
	int TravelYear;
	String quarterDivide;
	String TravelDivide;
	String evaluationTitle;
	String evaluationContent;
	String totalScore;
	String cultureScore;
	String creditScore;
	String comfortableScore;
	int likeCount;
	
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCountryName() {
		return countryName;
	}
	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}
	public String getRegionName() {
		return regionName;
	}
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
	public int getTravelYear() {
		return TravelYear;
	}
	public void setTravelYear(int travelYear) {
		TravelYear = travelYear;
	}
	public String getQuarterDivide() {
		return quarterDivide;
	}
	public void setQuarterDivide(String quarterDivide) {
		this.quarterDivide = quarterDivide;
	}
	public String getTravelDivide() {
		return TravelDivide;
	}
	public void setTravelDivide(String travelDivide) {
		TravelDivide = travelDivide;
	}
	public String getEvaluationTitle() {
		return evaluationTitle;
	}
	public void setEvaluationTitle(String evaluationTitle) {
		this.evaluationTitle = evaluationTitle;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getCultureScore() {
		return cultureScore;
	}
	public void setCultureScore(String cultureScore) {
		this.cultureScore = cultureScore;
	}
	public String getCreditScore() {
		return creditScore;
	}
	public void setCreditScore(String creditScore) {
		this.creditScore = creditScore;
	}
	public String getComfortableScore() {
		return comfortableScore;
	}
	public void setComfortableScore(String comfortableScore) {
		this.comfortableScore = comfortableScore;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public EvaluationDTO() {
		
	}
	
	public EvaluationDTO(int evaluationID, String userID, String countryName, String regionName, int travelYear,
			String quarterDivide, String travelDivide, String evaluationTitle, String evaluationContent,
			String totalScore, String cultureScore, String creditScore, String comfortableScore, int likeCount) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.countryName = countryName;
		this.regionName = regionName;
		TravelYear = travelYear;
		this.quarterDivide = quarterDivide;
		TravelDivide = travelDivide;
		this.evaluationTitle = evaluationTitle;
		this.evaluationContent = evaluationContent;
		this.totalScore = totalScore;
		this.cultureScore = cultureScore;
		this.creditScore = creditScore;
		this.comfortableScore = comfortableScore;
		this.likeCount = likeCount;
	}
	
	
}
