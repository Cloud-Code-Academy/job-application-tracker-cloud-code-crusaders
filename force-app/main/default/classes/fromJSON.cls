public class fromJSON{
	public Integer totalCount;
	public cls_jobs[] jobs;

	class cls_jobs {
		public String title;	
		public String location;	
		public String snippet;	
		public String salary;	
		public String source;	
		public String type;	
		public String link;	
		public String company;
		public String updated;
		public Integer id;	
	}

	public static fromJSON parse(String json){
		return (fromJSON) System.JSON.deserialize(json, fromJSON.class);
	}
}