package org.molgenis.data;

/**
 * Package defines the structure and attributes of a Package. Attributes are unique. Other software components can use
 * this to interact with Packages and/or to configure backends and frontends, including Repository instances.
 */
public interface Package
{
	public static final String DEFAULT_PACKAGE_NAME = "default";
	public static final String PACKAGE_SEPARATOR = "_";

	/**
	 * Gets the fully qualified name of this package
	 * 
	 * @return
	 */
	String getName();

	/**
	 * Gets the name of the package without the trailing parent packages
	 * 
	 * @return
	 */
	String getSimpleName();

	/**
	 * The description of this package
	 * 
	 * @return
	 */
	String getDescription();

	/**
	 * Gets the parent package or null if this package does not have a parent package
	 * 
	 * @return
	 */
	Package getParent();

}