using AutoDialer.Console.Models.Base;
using AutoDialer.Console.Repositories;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace AutoDialer.Console.Models
{
	/// <summary>
	/// ��������� ����������
	/// </summary>
	public class Group : Record
	{
		/// <summary>
		/// ������������
		/// </summary>
		public virtual string Title { get; set; }

		/// <summary>
		/// ������� ����� ����������� ��� ������
		/// </summary>
		public virtual bool Actived { get; set; }

		/// <summary>
		/// ���������� ������� ��� ���������� �������
		/// </summary>
		public virtual int CallCount { get; set; }

		/// <summary>
		/// ������������ �������� ������
		/// </summary>
		public virtual int WaitTime { get; set; }

		/// <summary>
		/// ������������ ���������� ������� � �������
		/// </summary>
		public virtual int CallMax { get; set; }

		/// <summary>
		/// ������� ������ � ������
		/// </summary>
		public virtual IList<Trunk> Trunks { get; set; }

		/// <summary>
		/// �����������
		/// </summary>
		public Group()
		{

		}

		/// <summary>
		/// �������� ������ ������� �������
		/// </summary>
		/// <returns></returns>
		public static async Task<IList<Group>> GetListAsync(GroupRepository repository)
		{
			return await repository.GetListAsync();
		}
	}
}