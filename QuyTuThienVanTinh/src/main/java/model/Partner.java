package model;

public class Partner {
	private int id;
	private String name;
	private String information;
	
	public Partner() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Partner(int id, String name, String information) {
		super();
		this.id = id;
		this.name = name;
		this.information = information;
	}

	public Partner(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getInformation() {
		return information;
	}

	public void setInformation(String information) {
		this.information = information;
	}
	
	
	
}
