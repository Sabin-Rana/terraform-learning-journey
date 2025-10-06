# Learning Notes for S3 and IAM

## S3 LEARNING NOTES - Digital Warehouse Analogy

### My Mental Model: Digital Storage Warehouse

Think of **S3** like a modern digital warehouse for your files:

| Real World Analogy | AWS Concept | Description |
|-------------------|-------------|-------------|
| Warehouse Building | **S3 Bucket** | Your storage container |
| Warehouse Address | **Bucket Name** | Unique global location |
| Storage Shelves | **Objects** | Your actual files |
| Access Rules | **Bucket Policy** | Who can enter/access |
| Public Entrance | **Website Hosting** | Public display area |
| Inventory Tags | **Metadata** | File descriptions |

### Core Components

**S3 Bucket**
- Your storage container for files
- Globally unique name required
- Region-specific but globally accessible

**Objects**
- Actual files you store (images, documents, etc.)
- Can be 0 bytes to 5TB in size
- Accessed via unique keys (like file paths)

**Bucket Policies**
- JSON documents defining access rules
- Control who can read/write/delete
- Can make buckets public or private

### Terraform Pattern Structure

**Step 1: Generate Unique Name**
- Use random provider for unique bucket names
- S3 bucket names must be globally unique

**Step 2: Create Storage Warehouse**
- Build the S3 bucket with unique name
- Configure basic settings and tags

**Step 3: Setup Public Access**
- Configure public access blocks
- Decide if warehouse is public or private

**Step 4: Configure Website Hosting**
- Enable static website hosting
- Set index and error documents

**Step 5: Set Access Rules**
- Create bucket policy for public/private access
- Define who can read/write files

**Step 6: Upload Files**
- Add objects (files) to the bucket
- Can create content directly in Terraform

---

## IAM LEARNING NOTES - Office Security System

### My Mental Model: Company Security System

Think of **IAM** like a corporate security and HR system:

| Real World Analogy | AWS Concept | Description |
|-------------------|-------------|-------------|
| Job Position | **IAM Role** | Set of permissions |
| Job Description | **IAM Policy** | What the role can do |
| Employee Badge | **Instance Profile** | Physical access card |
| Company Employee | **EC2 Instance** | Needs permissions to work |

### Core Components

**IAM Role**
- Identity with specific permissions
- Used by AWS services (EC2, Lambda, etc.)
- Defines "who" can do "what"

**IAM Policy**
- JSON document listing permissions
- Attached to roles, users, or groups
- Follows principle of least privilege

**Instance Profile**
- Container for IAM role
- Attached to EC2 instances
- Acts as security badge for EC2

### Terraform Pattern Structure

**Step 1: Create Job Position**
- Define IAM role with assume policy
- Specify which service can use this role

**Step 2: Write Job Description**
- Create IAM policy with specific permissions
- Define exactly what actions are allowed

**Step 3: Make Security Badge**
- Create instance profile for the role
- This connects the role to EC2 instances

**Step 4: Hire Employee**
- Launch EC2 instance with instance profile
- Employee now has the security badge

**Step 5: Verify Permissions**
- Test that EC2 can access allowed resources
- Confirm security boundaries work correctly

---

## Mental Checklist

### S3 Setup:
- [ ] Unique bucket name generated
- [ ] Bucket created with proper configuration
- [ ] Website hosting enabled if needed
- [ ] Access rules properly configured
- [ ] Files uploaded to bucket

### IAM Setup:
- [ ] IAM role with assume policy created
- [ ] IAM policy with specific permissions defined
- [ ] Policy attached to role
- [ ] Instance profile created
- [ ] Instance profile attached to EC2 instance