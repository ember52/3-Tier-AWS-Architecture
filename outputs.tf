output "networking" {
  value = module.networking
}

output "asg_names" {
  description = "Names of the auto scaling groups"
  value = {
    public_asg  = module.compute.public_asg_name
    private_asg = module.compute.private_asg_name
  }
}


output "key_pair" {
  value     = module.compute.private_key
  sensitive = true
}
